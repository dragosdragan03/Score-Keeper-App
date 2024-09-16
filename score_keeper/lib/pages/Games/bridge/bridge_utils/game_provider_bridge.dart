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
  basicUndertrick,
  firstDoubleUndertrick,
  additionalDoubleUndertrick,
  firstDoubleVulnerableUndertrick,
  additionalDoubleVulnerableUndertrick,
  firstRedoubleUndertrick,
  additionalRedoubleUndertrick,
  firstRedoubleVulnerableUndertrick,
  additionalRedoubleVulnerableUndertrick,
  fullRubberBonus,
  halfRubberBonus,
  doubleOvertrick,
  redoubleOvertrick,
  smallSlamVulnerableBonus,
  grandSlamVulerableBonus,
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
      case Score.smallSlamVulnerableBonus:
        return 750;
      case Score.grandSlamBonus:
        return 1000;
      case Score.grandSlamVulerableBonus:
        return 1500;
      case Score.basicUndertrick:
        return 50;
      case Score.fullRubberBonus:
        return 700;
      case Score.halfRubberBonus:
        return 500;
      case Score.doubleOvertrick:
        return 100;
      case Score.redoubleOvertrick:
        return 200;
      case Score.firstDoubleUndertrick:
        return 100;
      case Score.additionalDoubleUndertrick:
        return 200;
      case Score.firstDoubleVulnerableUndertrick:
        return 200;
      case Score.additionalDoubleVulnerableUndertrick:
        return 300;
      case Score.firstRedoubleUndertrick:
        return 200;
      case Score.additionalRedoubleUndertrick:
        return 400;
      case Score.firstRedoubleVulnerableUndertrick:
        return 400;
      case Score.additionalRedoubleVulnerableUndertrick:
        return 600;
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
  int multiplier = 1;
  Team? rubberWinner;

  GameProvider(String player1, String player2, String player3, String player4)
      : teamA = Team(player1: player1, player2: player2, teamName: "A"),
        teamB = Team(player1: player3, player2: player4, teamName: "B"),
        players = [player1, player2, player3, player4];

  void incrementScore(Team team, int value, String reason) {
    team.incrementScore(value, reason);
    notifyListeners();
  }

  void incrementBonus(Team team, int value, String reason) {
    team.incrementBonus(value, reason);
    notifyListeners();
  }

  Team otherTeam(Team team) {
    if (team == teamA) return teamB;
    return teamA;
  }

  void calculateForWin() {
    // Small slam
    if (currentBid == 6) {
      int value = !bidWinningTeam.vulnerable
          ? Score.smallSlamBonus.value
          : Score.smallSlamVulnerableBonus.value;
      String reason =
          !bidWinningTeam.vulnerable ? "Small Slam" : "Vulnerable Small Slam";
      incrementBonus(bidWinningTeam, value, reason);
    }

    // Grand slam
    if (currentBid == 7) {
      int value = !bidWinningTeam.vulnerable
          ? Score.grandSlamBonus.value
          : Score.grandSlamVulerableBonus.value;
      String reason =
          !bidWinningTeam.vulnerable ? "Grand Slam" : "Vulnerable Grand Slam";
      incrementBonus(bidWinningTeam, value, reason);
    }

    if (multiplier == 2) {
      int value = Score.doubleOvertrick.value *
          (tricksWon - 6 - currentBid) *
          (bidWinningTeam.vulnerable ? 2 : 1);
      String reason = bidWinningTeam.vulnerable
          ? "Vulnerable Double Overtrick"
          : "Double Overtrick";

      incrementBonus(bidWinningTeam, value, reason);
    }

    if (multiplier == 4) {
      int value = Score.redoubleOvertrick.value *
          (tricksWon - 6 - currentBid) *
          (bidWinningTeam.vulnerable ? 2 : 1);
      String reason = bidWinningTeam.vulnerable
          ? "Vulnerable Redouble Overtrick"
          : "Redouble Overtrick";

      incrementBonus(bidWinningTeam, value, reason);
    }

    // Small trump
    if (chosenTrickIndex < 2) {
      incrementScore(bidWinningTeam,
          multiplier * Score.smallTrump.value * currentBid, "Small trump");
      if (multiplier == 1) {
        incrementBonus(
            bidWinningTeam,
            Score.smallTrump.value * (tricksWon - 6 - currentBid),
            "Small trump overtricks");
      }
      return;
    }

    // Big trump
    if (chosenTrickIndex >= 2 && chosenTrickIndex < 4) {
      incrementScore(bidWinningTeam,
          multiplier * Score.bigTrump.value * currentBid, "Big trump");
      if (multiplier == 1) {
        incrementBonus(
            bidWinningTeam,
            Score.bigTrump.value * (tricksWon - 6 - currentBid),
            "Big trump overtrick");
      }
      return;
    }

    // No trump
    if (chosenTrickIndex == 4) {
      incrementScore(
          bidWinningTeam,
          multiplier *
              (Score.firstNoTrump.value +
                  Score.additionalNoTrump.value * (currentBid - 1)),
          "No trump");
      if (multiplier == 1) {
        incrementBonus(
            bidWinningTeam,
            Score.additionalNoTrump.value * (tricksWon - 6 - currentBid),
            "No trump overtrick");
      }
      return;
    }
  }

  void calculateForLose() {
    Team bonusWinningTeam = otherTeam(bidWinningTeam);
    int value = -1;
    String reason = "Error";

    // Not doubled
    if (multiplier == 1) {
      value = (currentBid + 6 - tricksWon) * Score.basicUndertrick.value;
      if (bidWinningTeam.vulnerable) {
        value *= 2;
        reason = "Vulnerable Basic Undertrick";
      } else {
        reason = "Basic Undertrick";
      }
    }

    if (multiplier == 2) {
      if (bidWinningTeam.vulnerable) {
        value = Score.firstDoubleVulnerableUndertrick.value +
            Score.additionalDoubleVulnerableUndertrick.value *
                (currentBid + 6 - tricksWon - 1);
        reason = "Vulnerable Double Undertrick";
      } else {
        value = Score.firstDoubleUndertrick.value +
            Score.additionalDoubleUndertrick.value *
                (currentBid + 6 - tricksWon - 1);
        reason = "Double Undertrick";
      }
    }

    if (multiplier == 4) {
      if (bidWinningTeam.vulnerable) {
        value = Score.firstRedoubleVulnerableUndertrick.value +
            Score.additionalRedoubleVulnerableUndertrick.value *
                (currentBid + 6 - tricksWon - 1);
        reason = "Vulnerable Redouble Undertrick";
      } else {
        value = Score.firstRedoubleUndertrick.value +
            Score.additionalRedoubleUndertrick.value *
                (currentBid + 6 - tricksWon - 1);
        reason = "Redouble Undertrick";
      }
    }
    incrementBonus(bonusWinningTeam, value, reason);
  }

  void finishRubber() {
    int value = otherTeam(bidWinningTeam).gamesWon == 0
        ? Score.fullRubberBonus.value
        : Score.halfRubberBonus.value;
    String reason =
        otherTeam(bidWinningTeam).gamesWon == 0 ? "Full Rubber" : "Half Rubber";
    incrementBonus(bidWinningTeam, value, reason);
    rubberWinner = teamA.total > teamB.total ? teamA : teamB;
  }

  void calculateScore() {
    if (tricksWon >= currentBid + 6) {
      calculateForWin();
      if (bidWinningTeam.score >= 100) {
        bidWinningTeam.winGame(gameNumber);
        otherTeam(bidWinningTeam).loseGame(gameNumber);
        gameNumber++;
        if (bidWinningTeam.gamesWon == 2) {
          finishRubber();
        }
      }
    } else {
      calculateForLose();
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
