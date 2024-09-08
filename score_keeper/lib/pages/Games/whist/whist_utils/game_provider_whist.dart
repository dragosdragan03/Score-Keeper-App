import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class GameProviderWhist extends ChangeNotifier {
  List<Player> players;
  bool gameType = false;
  bool replayRound = true;
  bool streakBonus = true;
  int streakBonusPoints = 5;
  int streakBonusRounds = 5;
  int playingRound = 0;
  int roundNumber = 1;
  bool inputTime = true;

  GameProviderWhist(List<Player> playersInput) : players = playersInput;

  int notAllowed() {
    int numberOfPlayers = players.length;
    int lastIndex = (numberOfPlayers - 1 + roundNumber - 1) % numberOfPlayers;
    int sumBids = 0;

    // Calculate the sum of all players' bets except the last player based on the current permutation
    for (int i = 0; i < numberOfPlayers; i++) {
      if (i != lastIndex) {
        sumBids += players[i].betRounds.last;
      }
    }

    print("Playing round:");
    print(roundNumber);
    print("Sum of all bets except the last player:");
    print(sumBids);

    int offNumber = playingRound - sumBids;

    return offNumber;
  }

  /// this method checks if all players bet wrongly
  bool verifyBidsWrong() {
    if (replayRound) {
      for (var player in players) {
        if (player.betRounds.last == player.resultRounds.last) {
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
      players[i].calculateScore(
          streakBonusPoints, streakBonus, playingRound, streakBonusRounds);
    }
    notifyListeners();
  }

  void updatePlayerBetRounds(int indexPlayer, int bid, bool replace) {
    players[indexPlayer].updateBetRounds(bid, replace);
    notifyListeners();
  }

  void updatePlayerResultRounds(int indexPlayer, int result, bool replace) {
    players[indexPlayer].updateResultRounds(result, replace);
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

  void eraseLastBetPlayer() {
    for (var player in players) {
      player.eraseLastBet();
      player.calculateScore(
          streakBonusPoints, streakBonus, playingRound, streakBonusRounds);
    }
    notifyListeners();
  }

  void eraseLastResultPlayer() {
    for (var player in players) {
      player.eraseLastResult();
      player.calculateScore(
          streakBonusPoints, streakBonus, playingRound, streakBonusRounds);
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
    inputTime = !inputTime;
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
