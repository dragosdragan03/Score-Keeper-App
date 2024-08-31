import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final Color pipeColor;

  const CustomTabBar({
    super.key,
    required this.children,
    required this.backgroundColor,
    required this.pipeColor,
  });

  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  int _selectedNumber = -1;

  int getSelectedNumber() {
    return _selectedNumber;
  }

  AnimatedContainer buildContainer(bool isSelected, int number, double width) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      width: 40 < width ? 40 : width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isSelected ? Colors.grey : widget.backgroundColor,
      ),
      child: Center(
        child: widget.children[number],
      ),
    );
  }

  Container verticalPipeline() {
    return Container(
      width: 2,
      height: 20,
      color: widget.pipeColor,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentWidth = constraints.maxWidth;

          return Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.children.expand((symbol) {
                bool isSelected =
                    widget.children.indexOf(symbol) == _selectedNumber;
                return [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedNumber = widget.children.indexOf(symbol);
                      });
                    },
                    child: buildContainer(
                        isSelected,
                        widget.children.indexOf(symbol),
                        (parentWidth - 20) / widget.children.length),
                  ),
                  if (symbol != widget.children.last) verticalPipeline()
                ];
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
