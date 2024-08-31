import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final bool isOn;
  final ValueChanged<bool> onToggle; // This is the callback function

  const SwitchButton({
    required this.isOn,
    required this.onToggle,
    super.key,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.isOn; // Initialize with the value passed from parent
  }

  void _toggleSwitch() {
    setState(() {
      _isSwitched = !_isSwitched;
      widget.onToggle(_isSwitched); // Notify parent widget about the toggle
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
              widget.onToggle(
                  _isSwitched); // Notify parent widget about the toggle
            });
          },
          activeColor: const Color.fromARGB(255, 217, 197, 11),
          inactiveThumbColor: const Color.fromARGB(255, 50, 164, 53),
          inactiveTrackColor: Colors.green.shade300,
          activeTrackColor: const Color.fromARGB(255, 251, 195, 105),
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
