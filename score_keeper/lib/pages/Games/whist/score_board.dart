import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/award_page.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/current_round.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/list_players.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/optionsButton.dart';
import 'package:score_keeper/pages/Games/whist/input_rounds.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/output_rounds.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/score_column.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/vertical_pipes.dart';

class ScoreBoard extends StatefulWidget {
  final bool gameType; // if the game is played 1..8..1 or 8..1..8
  final int streakBonusPoints;
  final bool replayRound;
  final int numberOfPlayers;

  const ScoreBoard({
    required this.numberOfPlayers,
    required this.gameType,
    required this.streakBonusPoints,
    required this.replayRound,
    super.key,
  });

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  final TextStyle commonTextStyle = const TextStyle(
      fontSize: 18.0,
      fontFamily: 'YourFontFamily', // Replace with your desired font family
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
      decorationThickness: 3.0);
  // int prevRoundNumber = 0;
  bool specialRounds = false; // if is on false this means it starts with 1
  int numberOfRounds = 0;
  // int roundNumber = 0;

  @override
  void initState() {
    super.initState();
    numberOfRounds = 12 + 3 * widget.numberOfPlayers;
    specialRounds = widget
        .gameType; // if is on false this means it starts with 1 otherwise it start with 8
    // if (specialRounds) {
    //   // this mean it start with 8
    //   roundNumber = 8;
    // } else {
    //   roundNumber = 1;
    // }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Whist Game Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  necessaryCard(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
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
      },
    );
  }

  String necessaryCard() {
    switch (widget.numberOfPlayers) {
      case 3:
        return "3 players: Ace to 9.";
      case 4:
        return "4 players: Ace to 7.";
      case 5:
        return "5 players: Ace to 5.";
      default:
        return "6 players: Ace to 3.";
    }
  }

  // int firstLastRounds() {
  //   if (!specialRounds) {
  //     // if is on false it means it start with 1
  //     return 1;
  //   } else {
  //     return 8;
  //   }
  // }

  int middleGame(GameProviderWhist gameProvider) {
    if (!specialRounds) {
      int roundNumber = gameProvider.playingRound;
      gameProvider.updatePlayingRound(roundNumber + 1);
      return gameProvider.playingRound;
    }
    // it means is descendent
    int roundNumber = gameProvider.playingRound;
    gameProvider.updatePlayingRound(roundNumber - 1);
    return roundNumber;
  }

  void navigateToInput(GameProviderWhist gameProvider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: gameProvider,
          child: InputRounds(
            numberOfPlayers: widget.numberOfPlayers,
            players: gameProvider.players,
            roundType: gameProvider.playingRound,
          ),
        ),
      ),
    );
  }

  void navigateToOutput(GameProviderWhist gameProvider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: gameProvider,
          child: OutputRounds(
            numberOfPlayers: widget.numberOfPlayers,
            players: gameProvider.players,
            roundType: gameProvider.playingRound,
          ),
        ),
      ),
    );
  }

  Future<void> handleRoundButtonPress(GameProviderWhist gameProvider) async {
    int startMiddleRounds = widget.numberOfPlayers + 6, // 8/1 rounds
        stopMiddleRounds = 2 * widget.numberOfPlayers + 6,
        startLastRounds = 2 * widget.numberOfPlayers + 12;
    // roundNumber; // final rounds 1/8

    // if (prevRoundNumber == gameProvider.roundNumber) {
    //   // it's used this in case the prev round was mistken by all players
    //   // (they all put the bids incorrect)
    //   roundNumber--;
    // }

    if (gameProvider.inputTime) {
      // it means is time to input the bids
      // if ((gameProvider.roundNumber <=
      //         widget.numberOfPlayers) || // this means are first rounds
      //     (startMiddleRounds < gameProvider.roundNumber &&
      //         gameProvider.roundNumber <=
      //             stopMiddleRounds) || // this means are the middle rounds
      //     (startLastRounds < gameProvider.roundNumber &&
      //         gameProvider.roundNumber < numberOfRounds)) {
      //   // this mean are the last rounds
      //   roundNumber = firstLastRounds();
      // } else
      if ((widget.numberOfPlayers < gameProvider.roundNumber &&
              gameProvider.roundNumber <= startMiddleRounds) ||
          (stopMiddleRounds < gameProvider.roundNumber &&
              gameProvider.roundNumber <= startLastRounds)) {
        middleGame(gameProvider);
      } else if (gameProvider.roundNumber == numberOfRounds + 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AwardPage(
                    playersName: gameProvider.playersName,
                  )),
        );
      }

      if (gameProvider.roundNumber == startMiddleRounds) {
        specialRounds = !specialRounds;
      } else if (gameProvider.roundNumber == startLastRounds) {
        specialRounds = !specialRounds;
      }
      // gameProvider.updatePlayingRound(roundNumber);
      // print("Input Round Type: $roundNumber\n\n");

      setState(() {
        for (int i = 0; i < gameProvider.players.length; i++) {
          gameProvider.updatePlayerBetRounds(i, 0, false);
        }
      });
      navigateToInput(gameProvider);
    } else {
      for (int i = 0; i < gameProvider.players.length; i++) {
        gameProvider.updatePlayerResultRounds(i, 0, false);
      }
      navigateToOutput(gameProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProviderWhist>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
        actions: [ChangeNotifierProvider.value(
          value: gameProvider,
          child: OptionsButton(),
        ),],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth / 5;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: ListPlayers(
                    playersName: gameProvider.playersName,
                    width: containerWidth,
                  ),
                ),
                // SizedBox(width: 0 // Adjust spacing proportionally
                //     ),
                Expanded(
                  flex: 1,
                  child:
                      VerticalPipes(numberOfLines: widget.numberOfPlayers + 1),
                ),
                // SizedBox(
                //   width: 1, // Adjust spacing proportionally
                // ),
                Expanded(
                  flex: 2,
                  child: CurrentRound(),
                ),
                SizedBox(
                  width: constraints.maxWidth *
                      0.03, // Adjust spacing proportionally
                ),
                Expanded(
                  flex: 1,
                  child:
                      VerticalPipes(numberOfLines: widget.numberOfPlayers + 1),
                ),
                Expanded(
                  flex: 1,
                  child: ScoreColumn(
                    scorePlayers: gameProvider.players
                        .map((player) => player.score)
                        .toList(),
                    width: containerWidth,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleRoundButtonPress(gameProvider),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
