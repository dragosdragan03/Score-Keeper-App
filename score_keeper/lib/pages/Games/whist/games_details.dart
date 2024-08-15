import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/score_board.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/switch.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

bool gameType = false;

class GamesDetails extends StatefulWidget {
  final int numberOfPlayers;

  const GamesDetails({
    required this.numberOfPlayers,
    super.key,
  });

  @override
  State<GamesDetails> createState() => _GamesDetailsState();
}

class _GamesDetailsState extends State<GamesDetails> {
  num streakPoints = 0;
  bool gameType = false; // to verify if the game is played 1..8..1 or 8..1..8
  bool replayRound = false;
  bool streakBonus = false; // consider it is not selected
  int numberOfRounds = 0;
  List<int> roudStreak = List.generate(3, (index) => (index + 1) * 5);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProviderWhist>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Game Mode')),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add padding around the entire body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the start
          children: [
            // Title with larger text
            const Text(
              "Game type",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0), // Space between title and description

            // Description text
            Text(
              "Select whether the game will start with 1 card per hand or 8 cards per hand.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32.0),

            // Row with text and switch button
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center align row items
              children: [
                const Text(
                  "1..8..1",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                // gameType = false;
                const SizedBox(width: 20.0), // Space between text and switch
                SwitchButton(
                  isOn: gameType,
                  onToggle: (value) {
                    setState(() {
                      gameType = value;
                    });
                    print("gameType toggled: $gameType");
                  },
                ),
                // if(gameType) // if it is true it means is 8..1..8
                // gameProvider.roundNumber = 1;
                const SizedBox(width: 20.0), // Space between switch and text
                const Text(
                  "8..1..8",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),

            const Text(
              "Streak Bonus",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "A player earns an award for a 7-game win or loss streak. Single-round games are not counted.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Switch(
                  value: streakBonus,
                  onChanged: (bool value) {
                    setState(() {
                      streakBonus = value;
                    });
                  },
                  activeColor: Colors.green,
                )
              ],
            ),
            if (streakBonus) // if is true than show the bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemCount(
                    initialValue: streakPoints,
                    minValue: 0,
                    maxValue: 15,
                    decimalPlaces: 0,
                    onChanged: (value) {
                      setState(() {
                        streakPoints = value;
                      });
                    },
                    color: Colors.green, // Optional
                    textStyle: const TextStyle(fontSize: 20), // Optional
                  ),
                ],
              ),
            const SizedBox(height: 32.0),
            const Text(
              "Replay Round",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Choose whether to replay the round if all players lose their hands.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Switch(
                  value: replayRound,
                  onChanged: (bool value) {
                    setState(() {
                      replayRound = value;
                    });
                  },
                  activeColor: Colors.green,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => GameProviderWhist(
                  gameProvider.players
                      .map((players) => Player(
                          name: players.name,
                          score: 0,
                          roundsWon: 0,
                          roundsLost: 0))
                      .toList(),
                ),
                child: ScoreBoard(
                  numberOfPlayers: widget.numberOfPlayers,
                  gameType: gameType,
                  streakBonusPoints: streakPoints.toInt(),
                  replayRound: replayRound,
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
