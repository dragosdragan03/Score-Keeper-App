import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

class TeamScoreDisplay extends StatefulWidget {
  final Team team;
  const TeamScoreDisplay({super.key, required this.team});

  @override
  State<TeamScoreDisplay> createState() => _TeamScoreDisplayState();
}

class _TeamScoreDisplayState extends State<TeamScoreDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Team ${widget.team.teamName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.team.getPlayer1(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            widget.team.getPlayer2(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text("Score: ${widget.team.score}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
