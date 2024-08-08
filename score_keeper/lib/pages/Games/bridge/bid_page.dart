import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/custom_tab_bar.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/player_bid_buttons.dart';
import 'package:score_keeper/pages/Games/bridge/tricks_page.dart';
import 'bridge_utils/constants.dart' as constants;

class BidPage extends StatefulWidget {
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  final GlobalKey<CustomTabBarState> _bidKey = GlobalKey<CustomTabBarState>();
  final GlobalKey<CustomTabBarState> _colorsKey =
      GlobalKey<CustomTabBarState>();

  bool noBid = false;
  bool noColor = false;
  bool noWinner = false;

  void onPressed(GameProvider gameProvider) {
    setState(() {
      noBid = _bidKey.currentState!.getSelectedNumber() == -1;
      noColor = _colorsKey.currentState!.getSelectedNumber() == -1;
      noWinner = gameProvider.bidWinner == -1;

      if (!noBid && !noColor && !noWinner) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                      value: gameProvider,
                      child: const TricksPage(),
                    )));
        gameProvider.chosenTrickIndex =
            _colorsKey.currentState!.getSelectedNumber();
        gameProvider.currentBid = _bidKey.currentState!.getSelectedNumber() + 7;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);

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
                      )
                    ],
                    title: const Text('Game Rules'),
                    contentPadding: const EdgeInsets.all(20.0),
                    content: const Text(
                        "Each of the partnerships tries to score points by taking any trick in excess of six. The partnership with the most points at the end of play wins the game."),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                // Bid winner selector

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Bid Winner",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const PlayerBidButtons(),
                    Container(
                      alignment: Alignment
                          .center, // Center the child within the container
                      child: Visibility(
                        visible: noWinner,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: const Text(
                          "Please input a winner",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                // Bid and color selector

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Bid selector

                    const Text(
                      "Bid",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTabBar(
                      key: _bidKey,
                      backgroundColor: Colors.black,
                      pipeColor: Colors.white,
                      children: List.generate(
                        7,
                        (int index) => Text(
                          "${index + 7}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      child: noBid
                          ? const Text(
                              "Please input a bid",
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // Color selector

                    const Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTabBar(
                      key: _colorsKey,
                      backgroundColor: Colors.white,
                      pipeColor: Colors.black,
                      children: constants.Constants.symbols,
                    ),
                    Container(
                      child: noColor
                          ? const Text(
                              "Please input a color",
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // "Next" button

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
