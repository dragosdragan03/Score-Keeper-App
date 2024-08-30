import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';

class CurrentRound extends StatefulWidget {
  CurrentRound({super.key});

  @override
  State<CurrentRound> createState() => _CurrentRoundState();
}

class _CurrentRoundState extends State<CurrentRound> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProviderWhist>(context, listen: true);

    // Print statements for debugging
    print("Current round Number: ${gameProvider.roundNumber}");
    if (gameProvider.players.isNotEmpty) {
      print("Lungime betRound: ${gameProvider.players[0].betRounds.length}");
      print(
          "Lungime resultRound: ${gameProvider.players[0].resultRounds.length}");
    } else {
      print("No players found.");
    }

    return Column(
      children: [
        const Text(
          "Round",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey,
              decorationThickness: 2.0),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "B",
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            SizedBox(
              width: 26.0,
            ),
            Text(
              "R",
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
          ],
        ),
        ...gameProvider.players
            .map(
              (player) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (gameProvider.roundNumber > 0 &&
                          gameProvider.roundNumber - 1 ==
                              player.betRounds.length &&
                          player.betRounds.isNotEmpty)
                        Text(
                          "${player.betRounds[gameProvider.roundNumber - 2]}",
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        )
                      else
                        const Text(
                          "-",
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 1.5,
                        height: 20.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      if (gameProvider.roundNumber > 0 &&
                          gameProvider.roundNumber - 1 ==
                              player.resultRounds.length &&
                          player.resultRounds.isNotEmpty)
                        Text(
                          "${player.resultRounds[gameProvider.roundNumber - 2]}",
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        )
                      else
                        const Text(
                          "-",
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
