import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';
import 'package:score_keeper/pages/Games/whist/whist_utils/table_score.dart';
import 'package:score_keeper/pages/history_page.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton({super.key});

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  @override
  Widget build(BuildContext context) {
    GameProviderWhist gameProvider =
        Provider.of<GameProviderWhist>(context);

    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert,
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
            showDialog(context: context,
                builder: (context) => AlertDialog(
                  title: const Text('History'),
                  content: ChangeNotifierProvider.value(value: gameProvider,
                      child: TableScore(),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ));
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
              color: Color.fromARGB(188, 9, 133, 100)), // Customize icon color
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
