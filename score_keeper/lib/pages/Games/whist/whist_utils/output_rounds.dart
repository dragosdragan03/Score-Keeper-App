// lib/input_rounds.dart

import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';

class OutputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final List<String> playersName;
  final List<Player> players;

  const OutputRounds({
    required this.numberOfPlayers,
    required this.playersName,
    required this.players,
    super.key,
  });

  @override
  State<OutputRounds> createState() => _OutputState();
}

class _OutputState extends State<OutputRounds> {
  List<int> _selectedNumbers = [];

  void initState() {
    super.initState();
    _selectedNumbers = List.generate(widget.numberOfPlayers, (index) => 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Text(
            'This is the Results page with ${widget.numberOfPlayers} players.'),
      ),
    );
  }
}
