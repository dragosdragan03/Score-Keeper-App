import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class GameProviderWhist extends ChangeNotifier {
  List<Player> players;
  List<String> playersName;
  List<int> results;
  List<int> bids;
  bool replayRound = true;
  bool streakBonus = true;
  int streakBonusPoints = 5;
  int streakBonusRounds = 5;
  int playingRound = 0;
  int roundNumber = 1;

  GameProviderWhist(List<Player> playersInput)
      : players = playersInput,
        playersName = List.generate(
            playersInput.length, (index) => playersInput[index].name),
        results = List.generate(playersInput.length, (index) => 0),
        bids = List.generate(
            playersInput.length, (index) => 0); // Correct initialization

  List<String> listPermutation(List<String> list) {
    if (list.isEmpty) return list;

    // Rotate the list by moving the first element to the end
    var firstElement = list.removeAt(0);
    list.add(firstElement);

    return list;
  }

  int notAllowed() {
    // this is the sum for all players except the last
    int sumBids = bids.sum - bids.last;
    int offNumber = playingRound - sumBids;
    if (offNumber < 0) {
      return -1;
    } else {
      return offNumber;
    }
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

  void setReplayRound(bool replayRound) {
    this.replayRound = replayRound;
    notifyListeners();
  }

  void setBids(List<int> bidsInput) {
    bids = bidsInput;
    notifyListeners();
  }

  /// this method checks if all players bet wrongly
  bool verifyBidsWrong() {
    if (replayRound) {
      for (int i = 0; i < bids.length; i++) {
        if (bids[i] == results[i]) {
          return false; // it means is at least one correct (NO REPLAY)
        }
      }

      return true; // it means all are different (REPLAY ROUND)
    }
    return false;
  }

  void setResult(List<int> resultsInput) {
    results = resultsInput;
    if (verifyBidsWrong()) {
      roundNumber--;
      notifyListeners();
      return;
    }
    _calculateScore();
  }

  void _calculateScore() {
    for (int i = 0; i < players.length; i++) {
      players[i].calculateScore(results[i], bids[i], streakBonusPoints,
          streakBonus, playingRound, streakBonusRounds);
    }
    players.sort((player1, player2) => player2.score.compareTo(
        player1.score)); // it's used to sprt the list based on the score
    notifyListeners();
  }

  void updatePlayingRound(int playingRound) {
    this.playingRound = playingRound;
    notifyListeners();
  }

  void incrementRoundNumber() {
    roundNumber++;
    playersName = listPermutation(playersName);
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

  void eraseLastRound() {
    for (var player in players) {
      player.eraseLastRound();
    }
    notifyListeners();
  }

  void eraseLastBet() {
    for (var player in players) {
      player.eraseLastBet();
    }
    notifyListeners();
  }

  void eraseLastResult() {
    for (var player in players) {
      player.eraseLastResult();
    }
    notifyListeners();
  }
}
