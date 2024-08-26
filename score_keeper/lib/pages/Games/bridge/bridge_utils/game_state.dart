import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

class GameState {
  final Team teamA, teamB;
  final int roundNumber, gameNumber;
  Team? rubberWinner;

  GameState({
    required this.teamA,
    required this.teamB,
    required this.roundNumber,
    required this.gameNumber,
    required this.rubberWinner,
  });
}
