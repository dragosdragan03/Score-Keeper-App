import 'package:flutter/material.dart';

class ListPlayers extends StatefulWidget {
  final List<String> playersName;
  final double width;

  const ListPlayers(
      {required this.width, required this.playersName, super.key});

  @override
  State<ListPlayers> createState() => _ListPlayersState();
}

class _ListPlayersState extends State<ListPlayers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Align items to the start
      children: [
        // Header
        const Text(
          'Name',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey,
              decorationThickness: 2.0),
        ),
        const SizedBox(height: 22.0), // Space between header and names

        // Convert the list of player names to widgets
        ...widget.playersName.map(
          (playerName) => Padding(
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
                playerName,
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
