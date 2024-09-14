import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/games_details.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/custom_listView.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart'; // Import ScoreBoard

class WhistGame extends StatefulWidget {
  const WhistGame({super.key});

  @override
  State<WhistGame> createState() => _WhistGameState();
}

class _WhistGameState extends State<WhistGame> {
  int numberOfPlayers = 0;
  bool introducedAllNames = true;
  bool isListVisible = false;
  List<TextEditingController> players = [];

  @override
  void initState() {
    super.initState();
    players = List.generate(numberOfPlayers, (_) => TextEditingController());
  }

  void submitButton() {
    introducedAllNames = true;
    setState(() {
      for (var name in players) {
        if (name.text.isEmpty) {
          introducedAllNames = false;
          break;
        }
      }
    });

    if (introducedAllNames) {
      final playerNames = players.map((controller) => controller.text).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => GameProviderWhist(
              playerNames.map((name) => Player(name: name, score: 0)).toList(),
            ),
            child: GamesDetails(
              numberOfPlayers: numberOfPlayers,
            ),
          ),
        ),
      );
    }
  }

  void updateControllers(int newCount) {
    if (newCount > players.length) {
      players.addAll(List.generate(
          newCount - players.length, (_) => TextEditingController()));
    } else if (newCount < players.length) {
      players.removeRange(newCount, players.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whist Game'),
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
                        "The goal of every player is to gain the most points. For the rounds with 1 to 7 cards there is also a card on the table, called "),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Choose the number of players",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            CustomTabBar(
              startIndex: 3,
              stopIndex: 6,
              step: 1,
              selectedNumber: numberOfPlayers,
              onNumberSelected: (int selectedNumber) {
                setState(() {
                  numberOfPlayers = selectedNumber;
                  isListVisible = true;
                  updateControllers(selectedNumber);
                });
              },
              offNumber: 0,
            ),
            if (isListVisible)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomListview(
                  value: numberOfPlayers,
                  areaController: players,
                ),
              ),
            if (isListVisible) const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AnimatedOpacity(
                opacity: isListVisible && !introducedAllNames ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: const Text(
                    "Warning: Please insert all players' names before proceeding with the game!",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: submitButton,
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
