import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int startIndex;
  final int stopIndex;
  final int step;
  final int selectedNumber;
  final ValueChanged<int> onNumberSelected;
  final int offNumber;

  const CustomTabBar({
    required this.startIndex,
    required this.stopIndex,
    required this.step,
    required this.selectedNumber,
    required this.onNumberSelected,
    required this.offNumber,
    super.key,
  });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedNumber = widget.selectedNumber;

  AnimatedContainer buildContainer(bool isSelected, int number, double width) {
    bool isOffNumber = number == widget.offNumber;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height:
          width, // Make the height equal to the width to maintain square shape
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isOffNumber
            ? Colors.transparent
            : (isSelected ? Colors.grey : Colors.black),
      ),
      child: isOffNumber
          ? null
          : Center(
              child: Text(
                "$number",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
    );
  }

  Container verticalPipeline(double height) {
    return Container(
      width: 2,
      height: 20,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Creating a list with the numbers needed
    List<int> numbers = List.generate(widget.stopIndex - widget.startIndex + 1,
        (int index) => widget.startIndex + index);

    return Padding(
      padding: const EdgeInsets.all(25),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the width of each container based on the available width
          double containerWidth =
              (constraints.maxWidth - (numbers.length - 1) * 12) /
                  numbers.length;
          double containerHeight = 40.0; // Fixed height

          return Container(
            height: containerHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: numbers.expand((number) {
                bool isSelected = number == _selectedNumber;
                bool isOffNumber = number == widget.offNumber;
                return [
                  GestureDetector(
                    onTap: isOffNumber
                        ? null // Prevent interaction if the number is offNumber
                        : () {
                            setState(() {
                              _selectedNumber = number;
                              widget.onNumberSelected(number);
                            });
                          },
                    child: buildContainer(isSelected, number, containerWidth),
                  ),
                  if (number != numbers.last) verticalPipeline(containerHeight)
                ];
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
