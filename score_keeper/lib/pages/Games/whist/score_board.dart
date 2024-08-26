import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/award_page.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/optionsButton.dart';
import 'package:score_keeper/pages/Games/whist/input_rounds.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/output_rounds.dart';

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
  int prevRoundNumber = 0;
  bool specialRounds = false; // if is on false this means it starts with 1
  bool isRoundOngoing = false;
  bool unlock = false; // used for player rotation
  int numberOfRounds = 0;
  int roundNumber = 0;

  @override
  void initState() {
    super.initState();
    numberOfRounds = 12 + 3 * widget.numberOfPlayers;
    specialRounds = widget
        .gameType; // if is on false this means it starts with 1 otherwise it start with 8
    if (specialRounds) {
      // this mean it start with 8
      roundNumber = 8;
    } else {
      roundNumber = 1;
    }
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

  int firstLastRounds() {
    if (!specialRounds) {
      // if is on false it means it start with 1
      return 1;
    } else {
      return 8;
    }
  }

  int middleGame() {
    if (!specialRounds) {
      // it means is ascendent
      roundNumber++;
      return roundNumber;
    }
    // it means is descendent
    roundNumber--;
    return roundNumber;
  }

  void handleRoundButtonPress(GameProviderWhist gameProvider) {
    int startMiddleRounds = widget.numberOfPlayers + 6, // 8/1 rounds
        stopMiddleRounds = 2 * widget.numberOfPlayers + 6,
        startLastRounds = 2 * widget.numberOfPlayers + 12; // final rounds 1/8

    if (prevRoundNumber == gameProvider.roundNumber) {
      // it's used this in case the prev round was mistken by all players
      // (they all put the bids incorrect)
      roundNumber--;
    }

    if (!isRoundOngoing) {
      // if is no round ongoing (you have to enter the bids)
      if ((gameProvider.roundNumber <=
              widget.numberOfPlayers) || // this means are first rounds
          (startMiddleRounds < gameProvider.roundNumber &&
              gameProvider.roundNumber <=
                  stopMiddleRounds) || // this means are the middle rounds
          (startLastRounds < gameProvider.roundNumber &&
              gameProvider.roundNumber < numberOfRounds)) {
        // this mean are the last rounds
        roundNumber = firstLastRounds();
      } else if ((widget.numberOfPlayers < gameProvider.roundNumber &&
              gameProvider.roundNumber <= startMiddleRounds) ||
          (stopMiddleRounds < gameProvider.roundNumber &&
              gameProvider.roundNumber <= startLastRounds)) {
        roundNumber = middleGame();
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
      gameProvider.updatePlayingRound(roundNumber);
      print("Input Round Type: $roundNumber\n\n");
      prevRoundNumber = gameProvider.roundNumber;
      gameProvider.incrementRoundNumber();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: gameProvider,
            child: InputRounds(
              numberOfPlayers: widget.numberOfPlayers,
              players: gameProvider.players,
              roundType: roundNumber,
            ),
          ),
        ),
      );
      setState(() {
        isRoundOngoing = true;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: gameProvider,
            child: OutputRounds(
              numberOfPlayers: widget.numberOfPlayers,
              players: gameProvider.players,
              roundType: roundNumber,
            ),
          ),
        ),
      );
      setState(() {
        isRoundOngoing = false;
        unlock = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProviderWhist>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
        actions: const [OptionsButton()],
      ),
      body: ListView.separated(
        itemCount: widget.numberOfPlayers,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: Colors.blueGrey[200],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gameProvider.players[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Score: ${gameProvider.players[index].score}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.white,
        ),
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
