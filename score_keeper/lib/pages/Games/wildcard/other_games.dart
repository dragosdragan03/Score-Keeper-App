import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/list_players.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/player.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/score_column.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/vertical_pipes.dart';
import 'package:score_keeper/pages/Games/wildcard/end_game.dart';
import 'package:score_keeper/pages/Games/whist/award_page.dart';

class OtherGames extends StatefulWidget {
  const OtherGames({super.key});

  @override
  State<OtherGames> createState() => _OtherGamesState();
}

class _OtherGamesState extends State<OtherGames> {
  List<Player> players = [];

  void addNewPlayer(BuildContext context) {
    String newName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Player Name'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            decoration: const InputDecoration(hintText: "Player Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                bool nameExists = false;
                if (players.map((player) => player.name).contains(newName)) {
                  nameExists = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Player with this name already exists!'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                if (newName.isNotEmpty && !nameExists) {
                  setState(() {
                    players.add(Player(name: newName));
                  });
                }
                Navigator.of(context).pop(); // Close the dialog after adding
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
        actions: [NewButton(players: players)],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double containerWidth = constraints.maxWidth / 3;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 10,
                          child: ListPlayers(
                            playersName:
                                List.from(players.map((player) => player.name)),
                            width: containerWidth,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              VerticalPipes(numberOfLines: players.length + 1),
                        ),
                        Expanded(
                          flex: 10,
                          child: ScoreColumn(
                            players: players,
                            width: containerWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        addNewPlayer(context);
                      },
                      icon: const Icon(Icons.add))
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class NewButton extends StatelessWidget {
  final List<Player> players;
  const NewButton({required this.players, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          players..sort((a, b) => b.score.compareTo(a.score));
          if (players.length > 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AwardPage(
                        playersName:
                            players.map((player) => player.name).toList(),
                      )),
            );
          } else {
            if (players.length < 2) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'A game of less than 2 player does not exist. Go outside, make some firends, than come back and play th game!'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EndGame(players: players)));
            }
          }
        },
        child: const Text("End Game"),
      ),
    );
  }
}
