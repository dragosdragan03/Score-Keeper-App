import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/rentz/game_page.dart';
import 'package:score_keeper/pages/Games/rentz/rentz_utils/tab_bar.dart';
import 'package:score_keeper/pages/Games/rentz/rentz_utils/custom_listView.dart';

class RentzGame extends StatefulWidget {
  const RentzGame({super.key});

  @override
  State<RentzGame> createState() => _RentzGameState();
}

class _RentzGameState extends State<RentzGame> {
  int numberOfPlayers = 3;
  bool introducedAllNames = true;
  bool isListVisible = false; // first time the list is hidden
  List<TextEditingController> players = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for the default number of players
    players = List.generate(numberOfPlayers, (_) => TextEditingController());
    // _fadeaway = Timer(Duration(seconds: 5) );
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
          builder: (context) => GamePage(
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
        // backgroundColor: Color.fromARGB(255, 5, 230, 250),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text('Rentz Game'),
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
                        "Rentz is a trick-taking card game for 4 players played over 8 rounds, with each round featuring a different contract. The aim is to score points based on the contracts. A standard 52-card deck is used, and the cards are ranked from Ace (high) to 2 (low). Each player is dealt 13 cards. The game consists of the following contracts: no tricks, no hearts, no queens, no last 2 tricks, most tricks, no king of hearts, no men (J, Q, K), and a 'Rentz' round, which is chosen by the dealer and can repeat any of the previous contracts. Players must follow the suit of the lead card if possible, and the highest card of the led suit wins the trick. After all tricks are played, points are tallied according to the specific contract of the round. The player with the fewest points at the end of 8 rounds wins the game."),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark))
        ],
      ),
      body: ListView(
        children: [
          // const Text("Choose the number of players",
          //     style: TextStyle(
          //       fontSize: 20,
          //     )),
          const Center(
            child: Text(
              "Choose the number of players",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

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
            ),
          )
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
