import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/main_page.dart';
import 'package:score_keeper/pages/Games/bridge/util/team_input.dart';

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
                builder: (context) =>
                    MainBridgePage(names[0], names[1], names[2], names[3])));
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
        title: const Text(
          'Bridge Game',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 80.0), // Add padding to avoid overlap
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
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: buttonPress,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
