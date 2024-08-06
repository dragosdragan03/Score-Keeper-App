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
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedNumber = -1;

  AnimatedContainer buildContainer(bool isSelected, int number) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      width: 40,
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
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
                      isSelected, widget.children.indexOf(symbol)),
                ),
                if (symbol != widget.children.last) verticalPipeline()
              ];
            }).toList(),
          ),
        ),
      ),
    );
  }
}
