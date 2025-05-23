import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/score_board.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/switch.dart';

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
  int numberRoundToBonus = 5; // this is a standard number to get promoted
  int streakPoints = 5;
  bool gameType = false; // to verify if the game is played 1..8..1 or 8..1..8
  bool replayRound = true;
  bool streakBonus = true; // consider it is not selected
  bool lastSum = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProviderWhist>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Game Mode')),
      body: Padding(
        padding:
            // const EdgeInsets.all(16.0), // Add padding around the entire body
            const EdgeInsets.only(
                bottom: 30.0,
                left: 16.0,
                right: 16.0), // Add padding around the body, except the top
        child: ListView(
          // Enable vertical scrolling
          children: [
            Column(
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
                const SizedBox(
                    height: 16.0), // Space between title and description

                // Description text
                Text(
                  "Select whether the game will start with 1 card per hand or 8 cards per hand.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10.0),

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
                    const SizedBox(
                        width: 20.0), // Space between text and switch
                    SwitchButton(
                      isOn: gameType,
                      onToggle: (value) {
                        setState(
                          () {
                            gameType = value;
                            gameProvider.setGameType(gameType);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                        width: 20.0), // Space between switch and text
                    const Text(
                      "8..1..8",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
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
                    const Expanded(
                      child: Text(
                        "Select whether a player gets awarded for a win or loss streak across multiple rounds.",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 97, 97, 97),
                        ),
                      ),
                    ),
                    Switch(
                      value: streakBonus,
                      onChanged: (bool value) {
                        setState(() {
                          streakBonus = value;
                          gameProvider.setStreakBonus(streakBonus);
                        });
                      },
                      activeColor: Colors.green,
                    )
                  ],
                ),
                if (streakBonus)
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "A player gets awarded for a win streak if the sum of the last ${gameProvider.streakBonusRounds} rounds is > 0.",
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 97, 97, 97),
                              ),
                            ),
                          ),
                          Switch(
                            value: lastSum,
                            onChanged: (bool value) {
                              setState(() {
                                lastSum = value;
                                gameProvider.setLastSum(lastSum);
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      ),
                    ],
                  ),

                if (streakBonus) // if true, show the bar
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Text(
                              'Points',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 97, 97, 97),
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow
                                  .ellipsis, // Optional: to handle overflow text
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Optional: adds some space between text and picker
                          NumberPicker(
                            axis: Axis.horizontal,
                            value: streakPoints,
                            minValue: 3,
                            maxValue: 15,
                            onChanged: (value) {
                              setState(() {
                                streakPoints = value;
                                gameProvider.setStreakBonusPoints(streakPoints);
                              });
                            },
                            textStyle:
                                const TextStyle(fontSize: 20), // Optional
                          ),
                        ],
                      ),
                    ],
                  ),

                if (streakBonus)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Rounds',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 97, 97, 97),
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow
                              .ellipsis, // Optional: to handle overflow text
                        ),
                      ),
                      NumberPicker(
                        axis: Axis.horizontal,
                        value: numberRoundToBonus,
                        minValue: 3,
                        maxValue: 10,
                        onChanged: (value) {
                          setState(() {
                            numberRoundToBonus = value;
                            gameProvider
                                .setStreakBonusRounds(numberRoundToBonus);
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 10.0),
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
                          gameProvider.setReplayRound(replayRound);
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 120.0),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (gameType) {
            // if is true this means it starts with 8
            gameProvider.setPlayingRound(8);
          } else {
            gameProvider.setPlayingRound(1);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: gameProvider, // Pass the existing provider instance here
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
