import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/player.dart';

class EndGame extends StatefulWidget {
  final List<Player> players;
  const EndGame({required this.players, super.key});
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('End Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Return to Games Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
