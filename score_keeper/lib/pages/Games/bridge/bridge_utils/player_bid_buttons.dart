import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider_bridge.dart';

class PlayerBidButtons extends StatefulWidget {
  const PlayerBidButtons({super.key});

  @override
  State<PlayerBidButtons> createState() => _PlayerBidButtonsState();
}

class _PlayerBidButtonsState extends State<PlayerBidButtons> {
  List<T> rotateList<T>(List<T> list, int rotations) {
    if (list.isEmpty) return list;
    rotations = rotations % 4;
    return list.sublist(rotations) + list.sublist(0, rotations);
  }

  @override
  Widget build(BuildContext context) {
    List<int> playerOrder = [0, 2, 1, 3];
    final gameProvider = Provider.of<GameProvider>(context);

    final gameNumber = gameProvider.roundNumber;
    playerOrder = rotateList(playerOrder, gameNumber);
    final players = gameProvider.players;

    return Column(
      children: playerOrder.map((number) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: gameProvider.bidWinner == number
                    ? Colors.grey
                    : Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                // Placeholder for onPressed logic
                gameProvider.setBidWinner(number);
              },
              child: Text(
                players[number],
                style: TextStyle(
                  color: gameProvider.bidWinner == number
                      ? Colors.black
                      : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
