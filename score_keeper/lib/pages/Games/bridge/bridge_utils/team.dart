import 'package:flutter/material.dart';
import 'bridge_player.dart';

class Team with ChangeNotifier {
  String teamName;
  late Player player1, player2;
  int score = 0;

  Team(String name1, String name2, this.teamName) {
    player1 = Player(name: name1);
    player2 = Player(name: name2);
  }

  String getPlayer1() {
    return player1.name;
  }

  String getPlayer2() {
    return player2.name;
  }

  void incrementScore(int value) {
    score += value;
    notifyListeners();
  }
}
