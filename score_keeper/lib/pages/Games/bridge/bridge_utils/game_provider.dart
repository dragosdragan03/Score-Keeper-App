import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

class GameProvider extends ChangeNotifier {
  Team teamA, teamB;
  List<String> players;
  int gameNumber = 0;
  int bidWinner = -1;

  GameProvider(String player1, String player2, String player3, String player4)
      : teamA = Team(player1, player2, "A"),
        teamB = Team(player3, player4, "B"),
        players = [player1, player2, player3, player4];

  void incrementScoreA() {
    teamA.incrementScore();
    gameNumber++;
    notifyListeners();
  }

  void setWinner(int number) {
    bidWinner = number;
    notifyListeners();
  }
}
