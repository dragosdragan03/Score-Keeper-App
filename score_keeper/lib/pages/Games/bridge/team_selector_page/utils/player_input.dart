import 'package:flutter/material.dart';

class PlayerInput extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final bool errorText;

  const PlayerInput({
    super.key,
    required this.controller,
    required this.name,
    required this.errorText,
  });

  @override
  State<PlayerInput> createState() => PlayerInputState();
}

class PlayerInputState extends State<PlayerInput> {
  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.errorText ? Colors.red : Colors.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(
            child: ClipOval(
              child: Container(
                width: 120.0, // Set the width of the oval
                height: 130.0, // Set the height of the oval
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/png-clipart-silhouette-man-silhouette-animals-silhouette-thumbnail.png'),
                    fit: BoxFit.cover, // Cover the entire oval
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.name,
              enabledBorder: border,
              focusedBorder: border,
              filled: true,
              fillColor: Colors.white,
            ),
            controller: widget.controller,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          if (widget.errorText)
            const Text(
              "Player name missing",
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
