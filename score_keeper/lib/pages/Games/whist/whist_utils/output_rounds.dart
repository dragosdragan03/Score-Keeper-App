import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';

class OutputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final int roundType;

  const OutputRounds({
    required this.numberOfPlayers,
    required this.roundType,
    super.key,
  });

  @override
  State<OutputRounds> createState() => _OutputState();
}

class _OutputState extends State<OutputRounds> {
  void _onNumberSelected(
      int playerIndex, int number, GameProviderWhist gameProvider) {
    setState(() {
      gameProvider.updatePlayerResultRounds(playerIndex, number, true);
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
    // print(_selectedNumbers);
    print(gameProvider.players.map((player) => player.resultRounds).toList());
    print(gameProvider.playingRound);
    int sumResults = gameProvider.players
        .map((player) => player.resultRounds.last)
        .reduce((value, element) => value + element);

    print(sumResults);
    bool isCorrect = gameProvider.verifyBidsWrong();
    setState(() {
      if (isCorrect) {
        showAlertDialog(context, 'Alert', "All players' bids are incorrect!");

        return;
      } else if (sumResults != gameProvider.playingRound) {
        showAlertDialog(context, 'Invalid Result!',
            "Total results must equal the round hands.");
        return;
      }
      // increment the round number only when is time to go to the next round
      gameProvider.calculateScore();
      gameProvider
          .incrementRoundNumber(); // this means it's time to go to the next round
      // gameProvider.updatePlayingRound(gameProvider.playingRound, false);
      gameProvider.changeRound();
      Navigator.pop(context);
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
                          "\t${gameProvider.players[(index + gameProvider.roundNumber - 1) % widget.numberOfPlayers].name}'s results:",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: CustomTabBar(
                            startIndex: 0,
                            stopIndex: widget.roundType,
                            step: 1,
                            selectedNumber: gameProvider
                                .players[
                                    (index + gameProvider.roundNumber - 1) %
                                        widget.numberOfPlayers]
                                .resultRounds
                                .last,
                            onNumberSelected: (number) => _onNumberSelected(
                                (index + gameProvider.roundNumber - 1) %
                                    widget.numberOfPlayers,
                                number,
                                gameProvider),
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
                    borderRadius: BorderRadius.circular(100),
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
