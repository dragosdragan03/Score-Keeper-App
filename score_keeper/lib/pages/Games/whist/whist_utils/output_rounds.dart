// lib/input_rounds.dart

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';

class OutputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final List<Player> players;
  final roundType;

  const OutputRounds({
    required this.numberOfPlayers,
    required this.players,
    required this.roundType,
    super.key,
  });

  @override
  State<OutputRounds> createState() => _OutputState();
}

class _OutputState extends State<OutputRounds> {
  List<int> _selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    _selectedNumbers = List.generate(widget.numberOfPlayers, (index) => 0);
  }

  void _onNumberSelected(
      int playerIndex, int number, GameProviderWhist gameProvider) {
    setState(() {
      gameProvider.updatePlayerResultRounds(playerIndex, number, true);
      _selectedNumbers[playerIndex] = number;
    });
  }

  void showAlertDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.0),
            Text(
              text,
              textAlign: TextAlign.start,
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
  }

  void _confirmAndGoBack(GameProviderWhist gameProvider) {
    setState(() {
      gameProvider.setResult(_selectedNumbers);
      Navigator.pop(context);
      if (gameProvider.verifyBidsWrong()) {
        showAlertDialog(context, 'Alert', "All players' bids are incorrect!");
      } else if (_selectedNumbers.sum > gameProvider.playingRound) {
        showAlertDialog(context, 'Invalid Result!',
            "Total results must equal the round hands.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GameProviderWhist gameProvider =
        Provider.of<GameProviderWhist>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.numberOfPlayers,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\t${gameProvider.playersName[index]}'s results:",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: CustomTabBar(
                            startIndex: 0,
                            stopIndex: widget.roundType,
                            step: 1,
                            selectedNumber: _selectedNumbers[index],
                            onNumberSelected: (number) =>
                                _onNumberSelected(index, number, gameProvider),
                            offNumber: -1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _confirmAndGoBack(gameProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
