import 'package:flutter/material.dart';

class ScoreColumn extends StatefulWidget {
  final List<int> scorePlayers;
  final double width;
  const ScoreColumn(
      {required this.width, required this.scorePlayers, super.key});

  @override
  State<ScoreColumn> createState() => _ScoreColumnState();
}

class _ScoreColumnState extends State<ScoreColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Align items to the start
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
        const SizedBox(height: 20.0), // Space between header and names

        // Convert the list of player names to widgets
        ...widget.scorePlayers.map(
          (scorePlayer) => Padding(
            padding:
                const EdgeInsets.only(bottom: 22.0), // Space around each name
            child: Container(
              width: widget.width,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
              ))),
              child: Text(
                "$scorePlayer",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
