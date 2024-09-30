import 'package:flutter/material.dart';

class CustomListview extends StatefulWidget {
  final int value;
  final List<TextEditingController> areaController;
  late bool introducedAllNames;

  CustomListview({
    required this.value,
    required this.areaController,
    required this.introducedAllNames,
    super.key,
  });

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  void updateNames() {
    print('updateNames');
    bool ok = true;
    for (var name in widget.areaController) {
      if (name.text.isEmpty) {
        ok = false;
        break;
      }
    }
    setState(() {
      widget.introducedAllNames = ok;
    });
  }

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
                onChanged: (value) {
                  print('Text changed for player ${index + 1}: $value');
                  updateNames(); // Simplified call
                },
                onEditingComplete: () {
                  print('Editing complete for player ${index + 1}');
                  updateNames(); // Simplified call
                  FocusScope.of(context)
                      .unfocus(); // Dismiss keyboard if needed
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
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
