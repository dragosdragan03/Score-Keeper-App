import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/table_score.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton({super.key});

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  void showAlertDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20.0),
            Text(
              text,
              textAlign: TextAlign.start,
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
  }

  void _eraseLastRound(GameProviderWhist gameProvider) {
    // i have to handle 2 case

    // if bids.length is bigger than results.length
    if (gameProvider.players[0].betRounds.isNotEmpty &&
        gameProvider.players[0].betRounds.length >
            gameProvider.players[0].resultRounds.length) {
      gameProvider.eraseLastBetPlayer();
      showAlertDialog(context, "Last Round Cleared",
          "The results of the last round have been successfully cleared. ");
      gameProvider.changeRound();
      return;
    }
    // if both have the same lenght i have to delete both last input
    if (gameProvider.players[0].betRounds.isNotEmpty &&
        gameProvider.players[0].betRounds.length ==
            gameProvider.players[0].resultRounds.length) {
      gameProvider.eraseLastRound();
      showAlertDialog(context, "Last Round Cleared",
          "The results of the last round have been successfully cleared. ");
      return;
    }
    showAlertDialog(context, "No Rounds to Clear",
        "There are no previous rounds to clear at this moment.");
    return;
  }

  @override
  Widget build(BuildContext context) {
    GameProviderWhist gameProvider = Provider.of<GameProviderWhist>(context);

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert,
          color: Colors.black), // Customize the icon color
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      itemBuilder: (context) => [
        _buildMenuItem(0, Icons.home, 'Home Page'),
        _buildMenuItem(1, Icons.repeat_rounded, 'New Game'),
        _buildMenuItem(2, Icons.history, 'History'),
        _buildMenuItem(3, Icons.info_outline, 'Rules'),
        _buildMenuItem(4, Icons.cleaning_services_rounded, 'Clear Last Round'),
      ],
      onSelected: (value) {
        switch (value) {
          case 0:
            Navigator.popUntil(context, (route) => route.settings.name == "/");
          case 1:
            Navigator.popUntil(
                context, (route) => route.settings.name == "/whist");
          case 2:
            showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), // Rounded corners
                // title: const Text('History'),
                child: ChangeNotifierProvider.value(
                  value: gameProvider,
                  child: const TableScore(),
                ),
                // actions: [
                //   TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: const Text('Close'),
                //   ),
                // ],
              ),
            );
          case 4:
            _eraseLastRound(gameProvider);
        }
      },
    );
  }

  PopupMenuItem<int> _buildMenuItem(int value, IconData icon, String text) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon,
              color: const Color.fromARGB(
                  188, 9, 133, 100)), // Customize icon color
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0, // Larger font size for better readability
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
