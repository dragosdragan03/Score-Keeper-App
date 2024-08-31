import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/score_element.dart';

class Team with ChangeNotifier {
  String teamName;
  String player1, player2;
  int score = 0;
  int bonus = 0;
  int total = 0;
  int gamesWon = 0;
  List<MaterialColor> games = [Colors.grey, Colors.grey, Colors.grey];
  List<ScoreElement> elements = [];
  bool vulnerable = false;

  Team({required this.player1, required this.player2, required this.teamName});

  Team clone() {
    Team cloneTeam =
        Team(player1: player1, player2: player2, teamName: teamName);

    cloneTeam.score = score;
    cloneTeam.bonus = bonus;
    cloneTeam.total = total;
    cloneTeam.gamesWon = gamesWon;
    cloneTeam.games = List<MaterialColor>.from(games);
    cloneTeam.elements = List<ScoreElement>.from(elements);
    cloneTeam.vulnerable = vulnerable;

    return cloneTeam;
  }

  void incrementScore(int value, String reason) {
    score += value;
    total += value;
    addScoreElement(ScoreElement(scoreSource: "Bid: $reason", score: value));
    notifyListeners();
  }

  void incrementBonus(int value, String reason) {
    bonus += value;
    total += value;
    if (value > 0) {
      addScoreElement(
          ScoreElement(scoreSource: "Bonus: $reason", score: value));
    }
    notifyListeners();
  }

  void winGame(int gameNumber) {
    games[gameNumber] = Colors.green;
    score = 0;
    bonus = 0;
    gamesWon++;
    vulnerable = true;
    notifyListeners();
  }

  void loseGame(int gameNumber) {
    score = 0;
    bonus = 0;
    games[gameNumber] = Colors.red;
    vulnerable = false;
    notifyListeners();
  }

  void addScoreElement(ScoreElement element) {
    elements.add(element);
  }
}
