import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/custom_tab_bar.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/player_bid_buttons.dart';

class BidPage extends StatefulWidget {
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  static const symbols = [
    Image(
      image: AssetImage('assets/card_symbols/Hearts.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitClubs.svg.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitDiamonds.svg.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitSpades.svg.png'),
      fit: BoxFit.cover,
    ),
    Text(
      "none",
      style: TextStyle(color: Colors.black),
    ),
  ];

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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bid Winner",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    PlayerBidButtons(),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 20),
                    const Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomTabBar(
                      backgroundColor: Colors.white,
                      pipeColor: Colors.black,
                      children: symbols,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            gameProvider.incrementScoreA();
          });
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
