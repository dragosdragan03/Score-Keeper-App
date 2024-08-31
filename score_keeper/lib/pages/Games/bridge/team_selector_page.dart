import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/game_provider.dart';
import 'package:score_keeper/pages/Games/bridge/main_page.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team_input.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final inputMissing = List<bool>.filled(4, false);

  // Create GlobalKeys for each TeamInput
  final GlobalKey<TeamInputState> _teamAKey = GlobalKey<TeamInputState>();
  final GlobalKey<TeamInputState> _teamBKey = GlobalKey<TeamInputState>();

  void buttonPress() {
    setState(() {
      bool ok = true;
      if (!_teamAKey.currentState!.foo()) ok = false;
      if (!_teamBKey.currentState!.foo()) ok = false;

      if (ok) {
        List<String> names =
            _controllers.map((controller) => controller.text).toList();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) =>
                    GameProvider(names[0], names[1], names[2], names[3]),
                child: const MainBridgePage(),
              ),
              settings: const RouteSettings(name: "/main-bridge-page"),
            ));
        for (var controller in _controllers) {
          controller.clear();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Game'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      )
                    ],
                    title: const Text('Game Rules'),
                    contentPadding: const EdgeInsets.all(20.0),
                    content: const Text(
                        "Each of the partnerships tries to score points by taking any trick in excess of six. The partnership with the most points at the end of play wins the game."),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark))
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 80.0), // Add padding to avoid overlap
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TeamInput(
                key: _teamAKey,
                teamName: "A",
                controller1: _controllers[0],
                controller2: _controllers[1],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TeamInput(
                key: _teamBKey,
                teamName: "B",
                controller1: _controllers[2],
                controller2: _controllers[3],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: buttonPress,
        child: const Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
