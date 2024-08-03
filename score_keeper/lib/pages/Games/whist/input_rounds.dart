import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class InputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final List<String> playersName;
  final List<Player> players;

  const InputRounds({
    required this.numberOfPlayers,
    required this.playersName,
    required this.players,
    super.key,
  });

  @override
  State<InputRounds> createState() => _InputRoundsState();
}

class _InputRoundsState extends State<InputRounds> {
  List<int> _selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    _selectedNumbers = List.generate(widget.numberOfPlayers, (index) => 1);
  }

  void _onNumberSelected(int playerIndex, int number) {
    setState(() {
      _selectedNumbers[playerIndex] = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Bids'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: widget.numberOfPlayers,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Input bid for " + widget.playersName[index] + ":",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: CustomTabBar(
                      startIndex: 0,
                      stopIndex: 8,
                      step: 1,
                      selectedNumber: _selectedNumbers[index],
                      onNumberSelected: (number) =>
                          _onNumberSelected(index, number),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
