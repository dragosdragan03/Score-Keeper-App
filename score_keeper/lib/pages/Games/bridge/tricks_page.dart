import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'bridge_utils/constants.dart' as constants;

class TricksPage extends StatefulWidget {
  const TricksPage({super.key});

  @override
  State<TricksPage> createState() => _TricksPageState();
}

class _TricksPageState extends State<TricksPage> {
  void onPressed(GameProvider gameProvider) {
    setState(() {
      gameProvider.calculateScore(tricksWon);
      Navigator.pop(context);
    });
  }

  int tricksWon = 0;

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    double cardWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Game'),
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
                    ),
                  ],
                  title: const Text('Game Rules'),
                  contentPadding: const EdgeInsets.all(20.0),
                  content: const Text(
                    "Each of the partnerships tries to score points by taking any trick in excess of six. The partnership with the most points at the end of play wins the game.",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: cardWidth,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Bid Winner",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          gameProvider.players[gameProvider.bidWinner],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: cardWidth,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Bid",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${gameProvider.currentBid}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 24.0),
                            ),
                            SizedBox(
                              height: 24.0,
                              child: constants.Constants
                                  .symbols[gameProvider.chosenTrickIndex],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0), // Add spacing before NumberPicker
              const Text("Tricks won"),
              Center(
                // Center the NumberPicker explicitly
                child: NumberPicker(
                  itemWidth: cardWidth / 4,
                  axis: Axis.horizontal,
                  value: tricksWon,
                  minValue: 0,
                  maxValue: 13,
                  onChanged: (value) => setState(() => tricksWon = value),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          onPressed(gameProvider);
        },
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
