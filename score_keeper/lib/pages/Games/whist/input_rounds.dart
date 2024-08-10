import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class InputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final List<String> playersName;
  final List<Player> players;
  final bool GameType;
  final int roundType;

  const InputRounds({
    required this.numberOfPlayers,
    required this.playersName,
    required this.players,
    required this.GameType,
    required this.roundType,
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

  void _confirmAndGoBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Bids'),
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
                          "\tInput bid for " + widget.playersName[index] + ":",
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
                                _onNumberSelected(index, number),
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
                onPressed: _confirmAndGoBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
