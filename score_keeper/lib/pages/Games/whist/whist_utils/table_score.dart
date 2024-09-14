import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';

class TableScore extends StatefulWidget {
  // final List<Player> players;

  const TableScore({super.key});

  @override
  State<TableScore> createState() => _TableScoreState();
}

class _TableScoreState extends State<TableScore> {
  @override
  Widget build(BuildContext context) {
    GameProviderWhist gameProvider = Provider.of<GameProviderWhist>(context);
    int numberOfColumns = gameProvider.players[0].betRounds.length + 1;
    final int currentNumberOfPlayers = gameProvider.players.length;
    double firstColumnWidth = 120.0;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Enable vertical scrolling
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First column (stationary "Players" column)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      _buildHeaderCell('Players', firstColumnWidth),
                      ...List.generate(currentNumberOfPlayers, (rowIndex) {
                        return _buildPlayerCell(
                            gameProvider.players[rowIndex].name,
                            firstColumnWidth); // Player names column
                      }),
                    ],
                  ),
                ),
              ],
            ),
            // Scrollable part (rounds columns)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    // Header row with custom headers for rounds
                    Row(
                      children: [
                        for (var i = numberOfColumns - 1; i >= 1; i--)
                          _buildHeaderCell(
                              GameProviderWhist.rnToPrDotIndex(
                                              i,
                                              gameProvider.players.length,
                                              gameProvider.gameType) %
                                          1 ==
                                      0
                                  ? GameProviderWhist.rnToPrDotIndex(
                                          i,
                                          gameProvider.players.length,
                                          gameProvider.gameType)
                                      .toInt()
                                      .toString() // Display as integer if no fractional part
                                  : GameProviderWhist.rnToPrDotIndex(
                                          i,
                                          gameProvider.players.length,
                                          gameProvider.gameType)
                                      .toString() // Display full double if fractional part exists
                              ,
                              75),
                      ],
                    ),
                    // Player rows for rounds
                    ...List.generate(currentNumberOfPlayers, (rowIndex) {
                      return Row(
                        children: [
                          for (int i = numberOfColumns - 1; i >= 1; i--)
                            _buildEmptyCell(rowIndex, i), // Empty round column
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      width: width,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCell(String text, double width) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      width: width,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildEmptyCell(int playerIndex, int roundIndex) {
    // print("playerIndex: $playerIndex, roundIndex: $roundIndex");
    const int unknownResult = -1;
    const int unknownScore = -999999;
    int intBid, intResult, intScore;
    GameProviderWhist gameProvider = Provider.of<GameProviderWhist>(context);
    // print("11111111");
    Player currPlayer = gameProvider.players[playerIndex];
    // print("22222222");
    intBid = currPlayer.betRounds[roundIndex - 1];
    // print("33333333");
    // print(
    //    "${currPlayer.betRounds.length} _______ ${currPlayer.resultRounds.length}");
    if (currPlayer.betRounds.length == currPlayer.resultRounds.length) {
      intResult = currPlayer.resultRounds[roundIndex - 1];
      // print("44444444");
      // print("table_score.dart: ${currPlayer.scoreRounds}");
      intScore = currPlayer.scoreRounds[roundIndex - 1];
      // print("55555555");
    } else {
      if (roundIndex == currPlayer.betRounds.length) {
        intResult = unknownResult;
        intScore = unknownScore;
      } else {
        // print("66666666");
        intResult = currPlayer.resultRounds[roundIndex - 1];
        // print("77777777");
        intScore = currPlayer.scoreRounds[roundIndex - 1];
      }
    }

    String bid = intBid.toString();
    String result = intResult == unknownResult ? "?" : intResult.toString();
    String score = intScore == unknownScore ? "?" : intScore.toString();
    bool incorrectBid;
    if (intResult == unknownResult) {
      incorrectBid = false;
    } else {
      incorrectBid = intBid == intResult ? false : true;
    }
    return Container(
      // padding: const EdgeInsets.all(16.0),
      width: 75,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                score,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      bid,
                      style: const TextStyle(
                        color: Colors.black,
                        // decoration: incorrectBid ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      result,
                      style: TextStyle(
                        color: incorrectBid
                            ? const Color.fromARGB(255, 168, 0, 0)
                            : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
