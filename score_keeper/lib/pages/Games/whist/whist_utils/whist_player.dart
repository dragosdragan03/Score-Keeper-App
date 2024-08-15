class Player {
  String name;
  int score;
  int roundsWon;
  int roundsLost;

  Player({
    required this.name,
    required this.score,
    required this.roundsWon,
    required this.roundsLost,
  });

  void calculateScore(int result, int bid) {
    if (result == bid) {
      score += result + 5;
    } else {
      score -= (result - bid).abs();
    }
  }
}
