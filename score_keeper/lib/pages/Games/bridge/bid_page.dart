import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/util/team.dart';
import 'main_page.dart';

class BidPage extends StatefulWidget {
  // final Team teamA, teamB;
  // const BidPage({super.key, required this.teamA, required this.teamB});
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  @override
  Widget build(BuildContext context) {
    final teamA = Provider.of<Team>(context);
    final teamB = Provider.of<Team>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bridge Game',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(children: [
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  teamA.incrementScore();
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Start Game",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
