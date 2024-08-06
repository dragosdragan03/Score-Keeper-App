import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/optionsButton.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';
import 'package:score_keeper/pages/Games/whist/input_rounds.dart' as Bids;
import 'package:score_keeper/pages/Games/whist/whist_utils/output_rounds.dart'
    as Outcomes;

bool isRound = false;

bool unlock = false; // pentru permutari

int first_rounds = 0, middle_rounds = 6, last_rounds = 0;

class ScoreBoard extends StatefulWidget {
  final int numberOfPlayers;
  final List<String> playersName;
  final bool gameType;

  const ScoreBoard({
    required this.numberOfPlayers,
    required this.playersName,
    required this.gameType,
    super.key,
  });

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List<Player> players = [];
  String necessaryCard() {
    if (widget.numberOfPlayers == 3) {
      return "3 players: Ace to 9.";
    } else if (widget.numberOfPlayers == 4) {
      return "4 players: Ace to 7.";
    } else if (widget.numberOfPlayers == 5) {
      return "5 players: Ace to 5.";
    } else {
      return "6 players: Ace to 3.";
    }
  }

  @override
  void initState() {
    super.initState();

    for (var name in widget.playersName) {
      Player player = new Player(
        name: name,
        score: 0,
        roundsWon: 0,
        roundsLost: 0,
      );
      players.add(player);
    }

    // if ()

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Whist Game Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20.0),
              Text(
                necessaryCard(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    });
  }

  List<DropdownMenuItem<dynamic>>? items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
        actions: const [OptionsButton()],
      ),
      body: ListView.separated(
        itemCount: widget.playersName.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: Colors.blueGrey[200],
            title: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Distribute space between the name and score
              children: [
                Text(
                  players[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Score: ${players[index].score}', // Display the player's score
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Add any desired action here
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isRound) {
            if (unlock) {
              Player lastPlayer = players.removeLast();
              players.insert(0, lastPlayer);
            }
            first_rounds = players.length;
            last_rounds = players.length;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Bids.InputRounds(
                        numberOfPlayers: players.length,
                        playersName:
                            players.map((player) => player.name).toList(),
                        players: players,
                        GameType: true,
                      )),
            );
            isRound = true;
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Outcomes.OutputRounds(
                        numberOfPlayers: players.length,
                        playersName:
                            players.map((player) => player.name).toList(),
                        players: players,
                      )),
            );
            isRound = false;
            unlock = true;
          }
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
