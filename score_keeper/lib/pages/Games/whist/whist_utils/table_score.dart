import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/whist_player.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';

class TableScore extends StatefulWidget {
  // final List<Player> players;



  const TableScore({ 
                      super.key});

  @override
  State<TableScore> createState() => _TableScoreState();
}

class _TableScoreState extends State<TableScore> {
  @override
  Widget build(BuildContext context) {
    GameProviderWhist gameProvider = Provider.of<GameProviderWhist>(context);
    int numberOfColumns = gameProvider.playingRound + 1;
    final int _currentNumberOfPlayers = gameProvider.players.length;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Enable vertical scrolling
        child: Container(
          height: MediaQuery.of(context).size.height, // Full screen height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rentz_assets/photo.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(
              top: 115.0, // Adjust as needed
            ),
            child: Column(
              children: [
                // LayoutBuilder to adapt table width
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate table width based on available space
                    double pColumnWidth = 120;
                    double tableWidth = pColumnWidth + (gameProvider.roundNumber - 1) * 75;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: tableWidth,
                        child: Table(
                          border: TableBorder.all(
                              color: Colors.white, width: 2.0), // Thicker border
                          columnWidths: {
                              0: const FixedColumnWidth(120),
                              for (var i = 1; i < numberOfColumns; i++)
                                i: const FixedColumnWidth(75),
                          },
                          children: [
                            // Header row with custom headers
                            TableRow(
                              children: [
                                _buildHeaderCell('Players'),
                                for (var i = 1; i <= gameProvider.players[0].betRounds.length; i++)
                                  _buildHeaderCell('$i'),
                              ],
                            ),
                            // Player rows
                            ...List.generate(_currentNumberOfPlayers, (rowIndex) {
                              return TableRow(
                                children: [
                                  _buildPlayerCell(gameProvider.players[rowIndex].name), // Player names column
                                  for (var i = 0; i < gameProvider.players[0].betRounds.length; i++)
                                    _buildEmptyCell(), // Empty round column
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Widget to show the current player's turn
                Container(
                  margin: const EdgeInsets.only(
                      top: 16.0), // Margin to lower the widget
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30), // Oval shape
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.7),
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

  Widget _buildPlayerCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.5),
      ),
      child: const Center(
        child: Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}