import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/team_selector_page/utils/player_input.dart';

class TeamInput extends StatefulWidget {
  final String teamName;
  final TextEditingController controller1;
  final TextEditingController controller2;

  const TeamInput({
    super.key,
    required this.teamName,
    required this.controller1,
    required this.controller2,
  });

  @override
  State<TeamInput> createState() => TeamInputState();
}

class TeamInputState extends State<TeamInput> {
  bool errorText1 = false, errorText2 = false;

  bool foo() {
    bool ok = true;
    setState(() {
      errorText1 = false;
      errorText2 = false;
      if (widget.controller1.text.isEmpty) {
        errorText1 = true;
        ok = false;
      }
      if (widget.controller2.text.isEmpty) {
        errorText2 = true;
        ok = false;
      }
    });
    return ok;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Team ${widget.teamName}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 240,
              child: PageView(
                controller: PageController(viewportFraction: 0.6),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  PlayerInput(
                    controller: widget.controller1,
                    name: "Player 1",
                    errorText: errorText1,
                  ),
                  PlayerInput(
                    controller: widget.controller2,
                    name: "Player 2",
                    errorText: errorText2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
