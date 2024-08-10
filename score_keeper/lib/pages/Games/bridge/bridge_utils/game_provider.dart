import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

class GameProvider extends ChangeNotifier {
  Team teamA, teamB;
  List<String> players;
  int gameNumber = -1;
  int bidWinner = -1;
  int currentBid = 0;
  int chosenTrickIndex = -1;
  late Team bidWinningTeam;

  GameProvider(String player1, String player2, String player3, String player4)
      : teamA = Team(player1, player2, "A"),
        teamB = Team(player3, player4, "B"),
        players = [player1, player2, player3, player4];

  void incrementScore(Team team, int value) {
    team.incrementScore(value);
    notifyListeners();
  }

  Team otherTeam(Team team) {
    if (team == teamA) return teamB;
    return teamA;
  }

  void calculateScore(int tricksWon) {
    if (tricksWon < currentBid) {
      incrementScore(otherTeam(bidWinningTeam), 70);
    } else {
      incrementScore(bidWinningTeam, 20);
    }
  }

  void setBidWinner(int number) {
    bidWinner = number;
    bidWinningTeam = bidWinner < 2 ? teamA : teamB;
    notifyListeners();
  }

  void incrementGame() {
    gameNumber++;
    notifyListeners();
  }
}
