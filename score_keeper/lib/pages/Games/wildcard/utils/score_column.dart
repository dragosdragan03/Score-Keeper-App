import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/player.dart';

class ScoreColumn extends StatefulWidget {
  final List<Player> players;
  final double width;
  const ScoreColumn({required this.width, required this.players, super.key});

  @override
  State<ScoreColumn> createState() => _ScoreColumnState();
}

class _ScoreColumnState extends State<ScoreColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Align items to the center
      children: [
        // Header
        const Text(
          'Score',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey,
              decorationThickness: 2.0),
        ),
        const SizedBox(height: 22.0), // Space between header and names

        // Convert the list of player scores to widgets
        ...widget.players.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(
                    bottom: 22.0), // Space around each score row
                child: Container(
                  padding: EdgeInsets.only(bottom: 4),
                  width: widget.width,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            entry.value.addScore(-1);
                          });
                        },
                        child: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          "${entry.value.score}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            entry.value.addScore(1);
                          });
                        },
                        child: const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
      ],
    );
  }
}
