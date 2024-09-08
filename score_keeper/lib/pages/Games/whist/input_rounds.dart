import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/tab_bar.dart';

class InputRounds extends StatefulWidget {
  final int numberOfPlayers;
  final int roundType;

  const InputRounds({
    required this.numberOfPlayers,
    required this.roundType,
    super.key,
  });

  @override
  State<InputRounds> createState() => _InputRoundsState();
}

class _InputRoundsState extends State<InputRounds> {
  // List<int> _selectedNumbers = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedNumbers = List.generate(widget.numberOfPlayers, (index) => 0);
  // }

  void _onNumberSelected(
      int playerIndex, int number, GameProviderWhist gameProvider) {
    int lastIndex =
        (widget.numberOfPlayers - 1 + gameProvider.roundNumber - 1) %
            widget.numberOfPlayers;
    setState(() {
      // update the input/bid for the player who changed the number
      gameProvider.updatePlayerBetRounds(playerIndex, number, true);
      int selectNr = gameProvider.players[lastIndex].betRounds.last;
      int offNumber = gameProvider.notAllowed();

      print("offNumber:");
      print(offNumber);

      if (selectNr == offNumber) {
        // Check if the current cell is the notAllowed number
        if (offNumber >= 0 && offNumber < gameProvider.playingRound) {
          // If the notAllowed is less than the playing round, move to the right cell
          selectNr += 1;
        } else if (offNumber > 0 && offNumber <= gameProvider.playingRound) {
          // Otherwise, move to the left cell
          selectNr -= 1;
        }
      }
      gameProvider.updatePlayerBetRounds(lastIndex, selectNr, true);
    });
  }

  void confirmAndGoBack(GameProviderWhist gameProvider) {
    setState(() {
      print(gameProvider.players.map((player) => player.betRounds).toList());
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
                  // Ensure the selected number for each player is updated in real time
                  // int selectedNumber = switchCell(gameProvider, index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\tInput bid for ${gameProvider.players[(index + gameProvider.roundNumber - 1) % widget.numberOfPlayers].name}:",
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
                                .betRounds
                                .last,
                            onNumberSelected: (number) => _onNumberSelected(
                                (index + gameProvider.roundNumber - 1) %
                                    widget.numberOfPlayers,
                                number,
                                gameProvider),
                            offNumber: index ==
                                    widget.numberOfPlayers -
                                        1 // for the last player
                                ? gameProvider.notAllowed()
                                : -1,
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
                onPressed: () => confirmAndGoBack(gameProvider),
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
