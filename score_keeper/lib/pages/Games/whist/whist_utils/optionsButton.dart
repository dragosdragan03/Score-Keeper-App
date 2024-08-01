import 'package:flutter/material.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton({super.key});

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: ElevatedButton(
            onPressed: null,
            // child: Text("Settings"),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.black),
                SizedBox(width: 8), // Spacing between icon and text
                Text("Settings", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ElevatedButton(
            onPressed: null,
            child: Row(
              children: [
                Icon(Icons.repeat_rounded, color: Colors.black),
                SizedBox(width: 8), // Spacing between icon and text
                Text(
                  "New Game",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ElevatedButton(
            onPressed: null,
            child: Row(
              children: [
                Icon(Icons.cleaning_services_rounded, color: Colors.black),
                SizedBox(width: 8), // Spacing between icon and text
                Text(
                  "Clear Last Round",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
