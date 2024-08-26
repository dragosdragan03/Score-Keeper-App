import 'package:flutter/material.dart';
import 'package:score_keeper/pages/Games/bridge/bridge_utils/team.dart';

class TeamScoreDisplay extends StatefulWidget {
  final Team team;
  const TeamScoreDisplay({super.key, required this.team});

  @override
  State<TeamScoreDisplay> createState() => _TeamScoreDisplayState();
}

class _TeamScoreDisplayState extends State<TeamScoreDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Team ${widget.team.teamName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.team.player1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            widget.team.player2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Games: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Icon(
                Icons.local_police_outlined,
                color: widget.team.games[0],
              ),
              Icon(
                Icons.local_police_outlined,
                color: widget.team.games[1],
              ),
              Icon(
                Icons.local_police_outlined,
                color: widget.team.games[2],
              )
            ],
          ),
          const SizedBox(height: 5),
          Text("Bonus: ${widget.team.bonus}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 5),
          Text("Score: ${widget.team.score}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 57, 74, 32),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                color: const Color.fromARGB(255, 73, 105, 26),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        width: 300.0, // Set a fixed width
                        height: 400.0, // Set a fixed height
                        child: ListView.builder(
                          itemCount: widget.team.elements.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      index != widget.team.elements.length - 1
                                          ? const BorderSide(
                                              color: Colors.grey,
                                            )
                                          : BorderSide.none,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        widget.team.elements[index].scoreSource,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        widget.team.elements[index].score
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text("Total: ${widget.team.total}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 73, 105, 26),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
