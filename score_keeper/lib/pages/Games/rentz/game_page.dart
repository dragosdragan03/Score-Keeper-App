import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/optionsButton.dart'; // For rootBundle

class GamePage extends StatefulWidget {
  final int numberOfPlayers;
  final List<String> players;

  const GamePage({
    required this.numberOfPlayers,
    required this.players,
    super.key,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int _currentNumberOfPlayers;
  late List<String> _currentPlayers;
  late int _currentPlayerIndex; // variable to keep track of the current player

  @override
  void initState() {
    super.initState();
    _currentNumberOfPlayers = widget.numberOfPlayers;
    _currentPlayers = List.from(widget.players);
    _currentPlayerIndex = 0; // Start with the first player
  }

  // Method to show the information dialog
  Future<void> _showInfoDialog() async {
    try {
      // Read the file content
      String fileContent = await rootBundle
          .loadString('assets/rentz_assets/games_descriptions.txt');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Information'),
            content: SizedBox(
              width: 400, // Adjust width as needed
              height: 300, // Adjust height as needed
              child: SingleChildScrollView(
                child: Text(fileContent),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle file read error
      print('Error reading file: $e');
    }
  }

  // Method to restart the game
  void _restartGame() {
    setState(() {
      _currentNumberOfPlayers = widget.numberOfPlayers;
      _currentPlayers = List.from(widget.players);
      _currentPlayerIndex = 0; // Reset to the first player
    });
    Navigator.of(context).pop(); // Navigate back to the previous page
  }

  // Method to show a confirmation dialog before restarting the game
  void _showRestartConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Restart Game'),
          content: const Text('Are you sure you want to restart the game?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _restartGame(); // Restart the game
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show the game rules
  void _showGamerulesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rentz Rules'),
          content: const Text('These are the game rules'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int numberOfColumns = 10;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Game Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        actions: [OptionsButton()],
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.rule_rounded, color: Colors.white, size: 28),
        //     tooltip: 'Game Information',
        //     onPressed: _showInfoDialog,
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
        //     tooltip: 'Restart Game',
        //     onPressed: _showRestartConfirmationDialog,
        //   ),
        //   IconButton(
        //     icon:
        //         const Icon(Icons.question_mark, color: Colors.white, size: 28),
        //     tooltip: 'Game Rules',
        //     onPressed: _showGamerulesDialog,
        //   ),
        // ],
      ),
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
                // Existing table wrapped in SingleChildScrollView
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width:
                        1200, // Set a fixed width to ensure the table is wide
                    child: Table(
                      border: TableBorder.all(
                          color: Colors.white, width: 2.0), // Thicker border
                      columnWidths: {
                        for (var i = 0; i < numberOfColumns; i++)
                          i: FlexColumnWidth(),
                      },
                      children: [
                        // Header row with custom headers
                        TableRow(
                          children: [
                            _buildHeaderCell('Players'),
                            _buildHeaderCell('Total Score'),
                            _buildHeaderCell('Whist'),
                            _buildHeaderCell('Totals -'),
                            _buildHeaderCell('K hearts'),
                            _buildHeaderCell('Queens'),
                            _buildHeaderCell('Diamonds'),
                            _buildHeaderCell('Levate'),
                            _buildHeaderCell('10 of clubs'),
                            _buildHeaderCell('Rentz'),
                          ],
                        ),
                        // Player rows
                        ...List.generate(_currentNumberOfPlayers, (rowIndex) {
                          return TableRow(
                            children: [
                              _buildPlayerCell(_currentPlayers[
                                  rowIndex]), // Player names column
                              _buildEmptyCell(), // Empty Total Score column
                              _buildEmptyCell(), // Empty Whist column
                              _buildEmptyCell(), // Empty Totals - column
                              _buildEmptyCell(), // Empty K hearts column
                              _buildEmptyCell(), // Empty Queens column
                              _buildEmptyCell(), // Empty Diamonds column
                              _buildEmptyCell(), // Empty Levate column
                              _buildEmptyCell(), // Empty 10 of clubs column
                              _buildEmptyCell(), // Empty Rentz column
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
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
                  child: Text(
                    'It\'s ${_currentPlayers.isNotEmpty ? _currentPlayers[_currentPlayerIndex] : 'No one'}\'s turn to chose the game.',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }

  Widget _buildPlayerCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: const Center(
        child: Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
