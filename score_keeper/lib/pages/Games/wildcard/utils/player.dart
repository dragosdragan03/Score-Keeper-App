import 'package:flutter/material.dart';

class Player {
  int score = 0;
  String name;

  Player({required this.name});

  void addScore(int value) {
    score += value;
  }
}
