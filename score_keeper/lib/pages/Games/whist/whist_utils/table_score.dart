import 'package:flutter/material.dart';

class TableScore extends StatefulWidget {
  const TableScore({super.key});

  @override
  State<TableScore> createState() => _TableScoreState();
}

class _TableScoreState extends State<TableScore> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
