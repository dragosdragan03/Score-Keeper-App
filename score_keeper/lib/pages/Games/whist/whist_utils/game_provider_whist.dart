import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class GameProviderWhist extends ChangeNotifier {
  List<Player> players;
  late List<int> results;
  late List<int> bids;
  int roundNumber = 1;

  GameProviderWhist(List<Player> playersInput) : players = playersInput;

  void setBids(List<int> bidsInput) {
    bids = bidsInput;
    notifyListeners();
  }

  void setResult(List<int> resultsInput) {
    results = resultsInput;
    _calculateScore();
  }

  void _calculateScore() {
    for (int i = 0; i < players.length; i++) {
      players[i].calculateScore(results[i], bids[i]);
      notifyListeners();
    }
  }

  void incrementRoundNumber() {
    roundNumber++;
    notifyListeners();
  }
}
