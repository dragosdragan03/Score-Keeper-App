import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class GameProviderWhist extends ChangeNotifier {
  static const INPUT = true;
  static const OUTPUT = false;
  List<Player> players;
  bool gameType = false;
  bool replayRound = true;
  bool streakBonus = true;
  bool lastSum = false;
  bool gameStarted = false;
  int streakBonusPoints = 5;
  int streakBonusRounds = 5;

  /// Represents the current number of cards given to every player (Whist).
  ///
  /// Example: roundNumber = 5, nrPlayers = 3, 1->8->1
  ///
  ///          playingRound = 5 - 3 = 2
  ///
  ///          1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 7, 6, ...
  int playingRound = 0;

  /// Represents the current round number (Whist).
  ///
  /// Example: roundNumber = 5, nrPlayers = 3, 1->8->1
  ///
  ///          playingRound = 5 - 3 = 2
  ///
  ///          1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, ...
  int roundNumber = 1;
  bool inputOutput = INPUT;

  GameProviderWhist(List<Player> playersInput) : players = playersInput;

  int notAllowed(List<int> selectedBids) {
    int numberOfPlayers = players.length;
    int lastIndex = (numberOfPlayers - 1 + roundNumber - 1) % numberOfPlayers;
    int sumBids = 0;

    // Calculate the sum of all players' bets except the last player based on the current permutation
    for (int i = 0; i < numberOfPlayers; i++) {
      if (i != lastIndex) {
        sumBids += selectedBids[i];
      }
    }

    // print("Playing round:");
    // print(roundNumber);
    // print("Sum of all bets except the last player:");
    // print(sumBids);

    int offNumber = playingRound - sumBids;

    return offNumber;
  }

  /// this method checks if all players bet wrongly
  bool verifyBidsWrong(List<int> selectedResults) {
    if (replayRound) {
      for (int i = 0; i < players.length; i++) {
        if (players[i].betRounds.last == selectedResults[i]) {
          return false;
        }
      }
      return true; // it means all are different (REPLAY ROUND)
    }
    return false;
  }

  List<Player> sortPlayersByScore() {
    // Create a new list, sort it in place, then return it
    List<Player> sortedPlayers = players.toList();
    sortedPlayers
        .sort((player1, player2) => player2.score.compareTo(player1.score));

    // Return the sorted list
    return sortedPlayers;
  }

  void calculateScore() {
    for (int i = 0; i < players.length; i++) {
      players[i].calculateScore(lastSum, streakBonusRounds, streakBonusPoints,
          streakBonus, players.length, gameType);
    }
    notifyListeners();
  }

  ///Erase last round (bids.length = results.length)
  void eraseLastRound() {
    for (int i = 0; i < players.length; i++) {
      players[i].eraseLastBet();
      players[i].eraseLastResult();
      players[i].eraseLastScore();
      if (players[i].scoreRounds.isNotEmpty) {
        players[i].score = players[i].scoreRounds.last;
      } else {
        players[i].score = 0;
      }
    }
    incrementRoundNumber(false);
    notifyListeners();
  }

  void erasePlayerLastBetRound(int indexPlayer) {
    players[indexPlayer].eraseLastBet();
    notifyListeners();
  }

  void erasePlayerLastResultRound(int indexPlayer) {
    players[indexPlayer].eraseLastResult();
    notifyListeners();
  }

  void erasePlayerLastScoreRound(int indexPlayer) {
    players[indexPlayer].eraseLastScore();
    notifyListeners();
  }

  void addPlayersBetRound(List<int> bets) {
    for (int i = 0; i < players.length; i++) {
      players[i].addBetRound(bets[i]);
    }
    notifyListeners();
  }

  void addPlayersResultRound(List<int> results) {
    for (int i = 0; i < players.length; i++) {
      players[i].addResultRound(results[i]);
    }
    notifyListeners();
  }

  void middleGame() {
    if (!gameType) {
      playingRound += 1;
      return;
    }
    // it means is descendent
    playingRound -= 1;
    return;
  }

  void updatePlayingRound() {
    int numberOfPlayers = players.length;

    if (!gameType) {
      // Ascending sequence: 1..8...1
      if (roundNumber <= numberOfPlayers) {
        playingRound = 1; // First 3 rounds: 1 card per player.
      } else if (roundNumber <= numberOfPlayers + 6) {
        playingRound = roundNumber + 1 - numberOfPlayers; // Increasing phase.
      } else if (roundNumber <= 2 * numberOfPlayers + 6) {
        playingRound = 8; // Peak rounds.
      } else if (roundNumber <= 2 * numberOfPlayers + 12) {
        playingRound =
            8 - (roundNumber - (2 * numberOfPlayers + 6)); // Decreasing phase.
      } else {
        playingRound = 1; // Last 3 rounds: 1 card per player.
      }
    } else {
      // Descending sequence: 8...1...8
      if (roundNumber <= numberOfPlayers) {
        playingRound = 8; // First 3 rounds: Peak rounds.
      } else if (roundNumber <= numberOfPlayers + 6) {
        playingRound = 8 - (roundNumber - numberOfPlayers); // Decreasing phase.
      } else if (roundNumber <= 2 * numberOfPlayers + 6) {
        playingRound = 1; // Peak Rounds
      } else if (roundNumber <= 2 * numberOfPlayers + 12) {
        playingRound =
            roundNumber - (2 * numberOfPlayers + 6); // Increasing phase.
      } else {
        playingRound = 8; // Last 3 rounds: 1 card per player.
      }
    }
    notifyListeners();
  }

  static double rnToPrDotIndex(
      int currRoundNumber, int numberOfPlayers, bool gameType) {
    // int numberOfPlayers = players.length;
    int currPlayingRound;
    int index;

    if (!gameType) {
      // Ascending sequence: 1..8...1
      if (currRoundNumber <= numberOfPlayers) {
        currPlayingRound = 1; // First 3 rounds: 1 card per player.
        index = currRoundNumber;
      } else if (currRoundNumber <= numberOfPlayers + 6) {
        currPlayingRound =
            currRoundNumber + 1 - numberOfPlayers; // Increasing phase.
        index = 0;
      } else if (currRoundNumber <= 2 * numberOfPlayers + 6) {
        currPlayingRound = 8; // Peak rounds.
        index = currRoundNumber - (numberOfPlayers + 6);
      } else if (currRoundNumber <= 2 * numberOfPlayers + 12) {
        currPlayingRound = 8 -
            (currRoundNumber - (2 * numberOfPlayers + 6)); // Decreasing phase.
        index = 0;
      } else {
        currPlayingRound = 1; // Last 3 rounds: 1 card per player.
        index = currRoundNumber - (2 * numberOfPlayers + 12);
      }
    } else {
      // Descending sequence: 8...1...8
      if (currRoundNumber <= numberOfPlayers) {
        currPlayingRound = 8; // First 3 rounds: Peak rounds.
        index = currRoundNumber;
      } else if (currRoundNumber <= numberOfPlayers + 6) {
        currPlayingRound =
            8 - (currRoundNumber - numberOfPlayers); // Decreasing phase.
        index = 0;
      } else if (currRoundNumber <= 2 * numberOfPlayers + 6) {
        currPlayingRound = 1; // 1 card per player.
        index = currRoundNumber - (numberOfPlayers + 6);
      } else if (currRoundNumber <= 2 * numberOfPlayers + 12) {
        currPlayingRound =
            currRoundNumber - (2 * numberOfPlayers + 6); // Increasing phase.
        index = 0;
      } else {
        currPlayingRound = 8; // Peak rounds.
        index = currRoundNumber - (2 * numberOfPlayers + 12);
      }
    }
    double result = currPlayingRound + index / 10;
    return result;
  }

  void allPlayersBetIncorrect() {
    for (int i = 0; i < players.length; i++) {
      erasePlayerLastBetRound(i);
    }
    changeRound();
    notifyListeners();
  }

  void eraseLastBetPlayer() {
    for (var player in players) {
      player.eraseLastBet();
      // player.calculateScore(lastSum, streakBonusRounds, streakBonusPoints,
      //     streakBonus, players.length, gameType);
    }
    notifyListeners();
  }

  void eraseLastResultPlayer() {
    for (var player in players) {
      player.eraseLastResult();
      player.calculateScore(lastSum, streakBonusRounds, streakBonusPoints,
          streakBonus, players.length, gameType);
    }
    notifyListeners();
  }

  void incrementRoundNumber(bool increment) {
    if (increment) {
      roundNumber++;
    } else {
      roundNumber--;
    }
    notifyListeners();
  }

  void changeRound() {
    inputOutput = !inputOutput;
    notifyListeners();
  }

  void setStreakBonusPoints(int streakBonusPoints) {
    this.streakBonusPoints = streakBonusPoints;
    notifyListeners();
  }

  void setStreakBonusRounds(int streakBonusRounds) {
    this.streakBonusRounds = streakBonusRounds;
    notifyListeners();
  }

  void setStreakBonus(bool streakBonus) {
    this.streakBonus = streakBonus;
    if (!streakBonus) {
      lastSum = false;
    }
    notifyListeners();
  }

  void setLastSum(bool lastSum) {
    this.lastSum = lastSum;
    notifyListeners();
  }

  void setGameType(bool gameType) {
    this.gameType = gameType;
    notifyListeners();
  }

  void setReplayRound(bool replayRound) {
    this.replayRound = replayRound;
    notifyListeners();
  }

  void setPlayingRound(int number) {
    playingRound = number;
    notifyListeners();
  }
}
