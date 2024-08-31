import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bid_page.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team_score_display.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/bridge/winner_page.dart';

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
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    )
                  ],
                  title: const Text('Game Rules'),
                  contentPadding: const EdgeInsets.all(20.0),
                  content: const Text(
                      "Each of the partnerships tries to score points by taking any trick in excess of six. The partnership with the most points at the end of play wins the game."),
                ),
              );
            },
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
              ],
            ),
          ),
          Positioned(
            bottom: 20, // Position 20 pixels from the bottom
            left: 16, // Align it 16 pixels from the left
            child: SizedBox(
              height: 56, // Match the height of the FloatingActionButton
              width: 56, // Match the width of the FloatingActionButton
              child: FloatingActionButton(
                onPressed: () {
                  if (gameProvider.previousGameStates.isNotEmpty) {
                    gameProvider.undoGame();
                  }
                },
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.undo,
                  color: Colors.white,
                ),
              ),
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
