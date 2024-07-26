import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge_game.dart';
import 'package:score_keeper/pages/Games/other_games.dart';
import 'package:score_keeper/pages/Games/rentz_game.dart';
import 'package:score_keeper/pages/Games/whist_game.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RentzGame()),
                );
              },
              child: const Text('Rentz'),
            ),
            const SizedBox(height: 20), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WhistGame()),
                );
              },
              child: const Text('Whist'),
            ),
            const SizedBox(height: 20), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BridgeGame()),
                );
              },
              child: const Text('Bridge'),
            ),
            const SizedBox(height: 20), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtherGames()),
                );
              },
              child: const Text('Other'),
            ),
          ],
        ),
      ),
    );
  }
}
