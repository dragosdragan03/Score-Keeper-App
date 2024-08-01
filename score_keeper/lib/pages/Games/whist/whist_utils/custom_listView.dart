import 'package:flutter/material.dart';

class CustomListview extends StatefulWidget {
  final int value;
  final List<TextEditingController> areaController;

  const CustomListview({
    required this.value,
    required this.areaController,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          children: List.generate(widget.value, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextField(
                controller: widget.areaController[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Player ${index + 1}',
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
