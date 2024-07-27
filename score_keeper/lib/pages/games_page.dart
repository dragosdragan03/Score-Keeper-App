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
      appBar: AppBar(
        title: const Text('Choose Game'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGameButton(
                context,
                icon: Icons.card_travel,
                label: 'Rentz',
                destination: const RentzGame(),
              ),
              _buildGameButton(
                context,
                icon: Icons.security,
                label: 'Whist',
                destination: const WhistGame(),
              ),
              _buildGameButton(
                context,
                icon: Icons.group,
                label: 'Bridge',
                destination: const BridgeGame(),
              ),
              _buildGameButton(
                context,
                icon: Icons.games,
                label: 'Other',
                destination: const OtherGames(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.deepPurple),
          title: Text(label,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
        ),
      ),
    );
  }
}
