import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/team_selector_page.dart';
import 'package:score_keeper/pages/Games/other_games.dart';
import 'package:score_keeper/pages/Games/rentz/rentz_game.dart';
import 'package:score_keeper/pages/Games/whist/whist_game.dart';

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
        decoration: const BoxDecoration(
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
              _buildGameButton(context,
                  icon: Icons.card_travel,
                  label: 'Rentz',
                  destination: const RentzGame(),
                  url: "/rentz"),
              _buildGameButton(context,
                  icon: Icons.security,
                  label: 'Whist',
                  destination: const WhistGame(),
                  url: "/whist"),
              _buildGameButton(context,
                  icon: Icons.group,
                  label: 'Bridge',
                  destination: const TeamsPage(),
                  url: "/bridge"),
              _buildGameButton(context,
                  icon: Icons.games,
                  label: 'Classic Score',
                  destination: const OtherGames(),
                  url: "/classic_score"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget destination,
      required String url}) {
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
              MaterialPageRoute(
                builder: (context) => destination,
                settings: RouteSettings(name: url),
              ),
            );
          },
        ),
      ),
    );
  }
}
