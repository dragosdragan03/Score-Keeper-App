import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isSwitched = false;

  void _toggleSwitch() {
    setState(() {
      _isSwitched = !_isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Switch(
          value: _isSwitched,
          onChanged: (bool value) {
            setState(() {
              _isSwitched = value;
            });
          },
          activeColor: Colors.red,
          inactiveThumbColor: const Color.fromARGB(255, 50, 164, 53),
          inactiveTrackColor: Colors.green.shade300,
          activeTrackColor: Colors.red.shade300,
        ),
        Positioned(
          left: _isSwitched ? null : 7,
          right: _isSwitched ? 8 : null,
          child: GestureDetector(
            // i use this in case i tap on the arrow
            onTap: _toggleSwitch,
            child: Icon(
              _isSwitched
                  ? Icons.arrow_circle_right_outlined
                  : Icons.arrow_circle_left_outlined,
              color: Colors.black,
              size: 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
