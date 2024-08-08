import 'package:flutter/material.dart';

class Constants {
  static const symbols = [
    Image(
      image: AssetImage('assets/card_symbols/Hearts.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitClubs.svg.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitDiamonds.svg.png'),
      fit: BoxFit.cover,
    ),
    Image(
      image: AssetImage('assets/card_symbols/SuitSpades.svg.png'),
      fit: BoxFit.cover,
    ),
    Text(
      "none",
      style: TextStyle(color: Colors.black),
    ),
  ];
}
