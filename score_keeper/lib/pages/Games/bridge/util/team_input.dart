import 'package:flutter/material.dart';

class TeamInput extends StatefulWidget {
  final String teamName;
  final TextEditingController controller1;
  final TextEditingController controller2;

  TeamInput({
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
    print(
        "${widget.teamName} $ok ${widget.controller1.text} ${widget.controller2.text}");
    return ok;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Team ${widget.teamName}",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Player 1",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              controller: widget.controller1,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Container(
              child: errorText1
                  ? Text(
                      "Please input a name",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    )
                  : null,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Player 2",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              controller: widget.controller2,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Container(
              child: errorText2
                  ? Text(
                      "Please input a name",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
