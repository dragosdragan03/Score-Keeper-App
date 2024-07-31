import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bid_page.dart';
import 'package:score_keeper/pages/Games/bridge/util/team.dart';
import 'package:score_keeper/pages/Games/bridge/util/team_score_display.dart';

class MainBridgePage extends StatefulWidget {
  final Team teamA;
  final Team teamB;

  MainBridgePage(String player1, String player2, String player3, String player4,
      {super.key})
      : teamA = Team(player1, player2, "A"),
        teamB = Team(player3, player4, "B");

  @override
  State<MainBridgePage> createState() => _MainBridgePageState();
}

class _MainBridgePageState extends State<MainBridgePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.teamA),
        ChangeNotifierProvider.value(value: widget.teamB),
      ],
      child: Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TeamScoreDisplay(team: widget.teamA),
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TeamScoreDisplay(team: widget.teamB),
                  ),
                ),
              ],
            ),
          ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BidPage()));
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
      ),
    );
  }
}
