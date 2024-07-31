import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/games_details.dart';
import 'package:score_keeper/utils/custom_listView.dart';
import 'package:score_keeper/utils/tab_bar.dart';

class WhistGame extends StatefulWidget {
  const WhistGame({super.key});

  @override
  State<WhistGame> createState() => _WhistGameState();
}

class _WhistGameState extends State<WhistGame> {
  int numberOfPlayers = 3;
  bool introducedAllNames = true;
  bool isListVisible = false; // first time the list is hidden
  List<TextEditingController> players = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for the default number of players
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GamesDetails()),
      );
    }
  }

  void updateControllers(int newCount) {
    if (newCount > players.length) {
      // Add more controllers if the new count is greater
      players.addAll(List.generate(
          newCount - players.length, (_) => TextEditingController()));
    } else if (newCount < players.length) {
      // Remove controllers if the new count is lesser
      players.removeRange(newCount, players.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whist Game'),
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
              icon: Icon(Icons.question_mark))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Choose the number of players",
              style: TextStyle(
                fontSize: 20,
              )),
          Container(
            child: CustomTabBar(
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
                }),
          ),
          if (isListVisible)
            CustomListview(
              value: numberOfPlayers,
              areaController: players,
            ),
          // if (isListVisible && !introducedAllNames)
          //   const Text("introduceti toate numele"),
        ],
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
