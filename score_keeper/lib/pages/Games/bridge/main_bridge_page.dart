import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bid_page.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team_score_display.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/bridge/winner_page.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/options_button.dart';

class MainBridgePage extends StatefulWidget {
  const MainBridgePage({super.key});

  @override
  State<MainBridgePage> createState() => _MainBridgePageState();
}

class _MainBridgePageState extends State<MainBridgePage> {
  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Game'),
        automaticallyImplyLeading: false,
        actions: [
          ChangeNotifierProvider.value(
              value: gameProvider, child: const OptionsButton())
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TeamScoreDisplay(team: gameProvider.teamA),
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TeamScoreDisplay(team: gameProvider.teamB),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (gameProvider.rubberWinner == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: gameProvider,
                  child: const BidPage(),
                ),
              ),
            );
            gameProvider.multiplier = 1;
            gameProvider.saveGameState();
            gameProvider.setBidWinner(-1);
            gameProvider.incrementGame();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WinnerPage(
                  player1: gameProvider.rubberWinner!.player1,
                  player2: gameProvider.rubberWinner!.player2,
                ),
              ),
            );
          }
        },
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
