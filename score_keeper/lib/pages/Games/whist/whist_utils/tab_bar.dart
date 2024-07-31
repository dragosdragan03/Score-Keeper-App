import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int startIndex;
  final int stopIndex;
  final int step;
  final int selectedNumber;
  final ValueChanged<int> onNumberSelected;

  const CustomTabBar({
    required this.startIndex,
    required this.stopIndex,
    required this.step,
    required this.selectedNumber,
    required this.onNumberSelected,
    Key? key,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedNumber = 0;

  AnimatedContainer buildContainer(bool isSelected, int number) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isSelected ? Colors.grey : Colors.black,
      ),
      child: Center(
        child: Text(
          "$number",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  Container verticalPipeline() {
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
        (int index) => (widget.startIndex + index) * widget.step);

    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: numbers.expand((number) {
            bool isSelected = number == _selectedNumber;
            return [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedNumber = number;
                    widget.onNumberSelected(number);
                  });
                },
                child: buildContainer(isSelected, number),
              ),
              if (number != numbers.last) verticalPipeline()
            ];
          }).toList(),
        ),
      ),
    );
  }
}
