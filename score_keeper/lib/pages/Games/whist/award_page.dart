import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podium/flutter_podium.dart';

class AwardPage extends StatefulWidget {
  final List<String> playersName;
  const AwardPage({required this.playersName, super.key});

  @override
  _AwardPageState createState() => _AwardPageState();
}

class _AwardPageState extends State<AwardPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingPlayers = widget.playersName.length > 3
        ? widget.playersName.skip(3).toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Podium(
                  horizontalSpacing: 12,
                  firstPosition: Text(
                    widget.playersName[0],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondPosition: Text(
                    widget.playersName[1],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  thirdPosition: Text(
                    widget.playersName[2],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  showRankingNumberInsteadOfText: true,
                  color: Colors.purple,
                ),
                if (remainingPlayers.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200, // Fixed height for the ListView
                    child: ListView.builder(
                      itemCount: remainingPlayers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "${index + 4}. ${remainingPlayers[index]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive, // Default
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                shouldLoop: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
