import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/list_players.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/player.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/score_column.dart';
import 'package:score_keeper/pages/Games/wildcard/utils/vertical_pipes.dart';

class OtherGames extends StatefulWidget {
  const OtherGames({super.key});

  @override
  State<OtherGames> createState() => _OtherGamesState();
}

class _OtherGamesState extends State<OtherGames> {
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
        actions: const [/* OptionsButton() */],
      ),
      body: LayoutBuilder(
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
                      child: VerticalPipes(numberOfLines: players.length + 1),
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
                    setState(() {
                      players.add(Player(name: "marian"));
                    });
                  },
                  icon: const Icon(Icons.add))
            ],
          );
        },
      ),
    );
  }
}
