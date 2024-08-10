import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/games_details.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/custom_listView.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';

class WhistGame extends StatefulWidget {
  const WhistGame({super.key});

  @override
  State<WhistGame> createState() => _WhistGameState();
}

class _WhistGameState extends State<WhistGame> {
  int numberOfPlayers = 3;
  bool introducedAllNames = true;
  bool isListVisible = false; // first time the list is hidden
  List<TextEditingController> players = []; // players names

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
        MaterialPageRoute(
          builder: (context) => GamesDetails(
            players: players.map((controller) => controller.text).toList(),
            numberOfPlayers: numberOfPlayers,
          ),
        ),
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
          const Spacer(), // Takes up remaining space
          Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0), // Add space from the bottom
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
                  "Warning: Please insert all players names before proceeding with the game!",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
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
            ),
            if (isListVisible)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomListview(
                  value: numberOfPlayers,
                  areaController: players,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomListview(
                  value: 3,
                  areaController: players,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AnimatedOpacity(
                opacity: isListVisible && !introducedAllNames ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.all(16.0),
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
