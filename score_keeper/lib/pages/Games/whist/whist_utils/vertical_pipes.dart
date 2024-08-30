import 'package:flutter/material.dart';

class VerticalPipes extends StatelessWidget {
  final int numberOfLines;

  const VerticalPipes({
    required this.numberOfLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define local variables
    final double lineThickness = 1.5;
    final double lineHeight = 25.0;
    final double spacing = 25.0;

    // Generate the list of vertical lines and return directly
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: List.generate(
          numberOfLines,
          (index) {
            return Column(
              children: [
                // SizedBox(height: spacing), // space above the line
                Container(
                  width: lineThickness,
                  height: lineHeight,
                  color: Colors.grey,
                ),
                SizedBox(height: spacing), // space below the line
              ],
            );
          },
        ),
      ),
    );
  }
}
