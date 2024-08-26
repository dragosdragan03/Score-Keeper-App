import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_state.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

enum Score {
  smallTrump,
  bigTrump,
  firstNoTrump,
  additionalNoTrump,
  smallSlamBonus,
  grandSlamBonus,
  undertrick,
  fullRubberBonus,
  halfRubberBonus
}

extension ScoreValue on Score {
  int get value {
    switch (this) {
      case Score.smallTrump:
        return 20;
      case Score.bigTrump:
        return 30;
      case Score.firstNoTrump:
        return 40;
      case Score.additionalNoTrump:
        return 30;
      case Score.smallSlamBonus:
        return 500;
      case Score.grandSlamBonus:
        return 1000;
      case Score.undertrick:
        return 50;
      case Score.fullRubberBonus:
        return 700;
      case Score.halfRubberBonus:
        return 500;
    }
  }
}

class GameProvider extends ChangeNotifier {
  Team teamA, teamB;
  List<String> players;
  int roundNumber = -1;
  int bidWinner = -1;
  int currentBid = 0;
  int tricksWon = 0;
  int chosenTrickIndex = -1;
  int gameNumber = 0;
  late Team bidWinningTeam;
  List<GameState> previousGameStates = [];
  Team? rubberWinner;

  GameProvider(String player1, String player2, String player3, String player4)
      : teamA = Team(player1: player1, player2: player2, teamName: "A"),
        teamB = Team(player1: player3, player2: player4, teamName: "B"),
        players = [player1, player2, player3, player4];

  void incrementScore(Team team, int value) {
    team.incrementScore(value);
    notifyListeners();
  }

  void incrementBonus(Team team, int value) {
    team.incrementBonus(value);
    notifyListeners();
  }

  Team otherTeam(Team team) {
    if (team == teamA) return teamB;
    return teamA;
  }

  void calculateForWinner() {
    if (currentBid == 6) {
      incrementBonus(bidWinningTeam, Score.smallSlamBonus.value);
    }
    if (currentBid == 7) {
      incrementBonus(bidWinningTeam, Score.grandSlamBonus.value);
    }
    if (chosenTrickIndex < 2) {
      incrementScore(bidWinningTeam, Score.smallTrump.value * currentBid);
      incrementBonus(bidWinningTeam,
          Score.smallTrump.value * (tricksWon - 6 - currentBid));
      return;
    }
    if (chosenTrickIndex >= 2 && chosenTrickIndex < 4) {
      incrementScore(bidWinningTeam, Score.bigTrump.value * currentBid);
      incrementBonus(
          bidWinningTeam, Score.bigTrump.value * (tricksWon - 6 - currentBid));
      return;
    }
    if (chosenTrickIndex == 4) {
      incrementScore(
          bidWinningTeam,
          Score.firstNoTrump.value +
              Score.additionalNoTrump.value * (currentBid - 1));
      incrementBonus(bidWinningTeam,
          Score.additionalNoTrump.value * (tricksWon - 6 - currentBid));
      return;
    }
  }

  void finishRubber() {
    incrementBonus(
        bidWinningTeam,
        otherTeam(bidWinningTeam).gamesWon == 0
            ? Score.fullRubberBonus.value
            : Score.halfRubberBonus.value);
    rubberWinner = bidWinningTeam;
  }

  void calculateScore() {
    if (tricksWon >= currentBid + 6) {
      calculateForWinner();
      if (bidWinningTeam.score >= 100) {
        bidWinningTeam.winGame(gameNumber);
        otherTeam(bidWinningTeam).loseGame(gameNumber);
        gameNumber++;
        if (bidWinningTeam.gamesWon == 2) {
          finishRubber();
        }
      }
    } else {
      incrementBonus(otherTeam(bidWinningTeam),
          Score.undertrick.value * (currentBid + 6 - tricksWon));
    }
  }

  void setBidWinner(int number) {
    bidWinner = number;
    bidWinningTeam = bidWinner < 2 ? teamA : teamB;
    notifyListeners();
  }

  void incrementGame() {
    roundNumber++;
    notifyListeners();
  }

  void saveGameState() {
    previousGameStates.add(GameState(
        teamA: teamA.clone(),
        teamB: teamB.clone(),
        roundNumber: roundNumber,
        gameNumber: gameNumber,
        rubberWinner: rubberWinner));
  }

  void undoGame() {
    GameState previousGame = previousGameStates.removeLast();
    teamA = previousGame.teamA;
    teamB = previousGame.teamB;
    roundNumber = previousGame.roundNumber;
    gameNumber = previousGame.gameNumber;
    rubberWinner = previousGame.rubberWinner;
    notifyListeners();
  }
}
