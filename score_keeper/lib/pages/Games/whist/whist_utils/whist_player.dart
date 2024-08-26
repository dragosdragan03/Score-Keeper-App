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

  void calculateScore(
      int result,
      int bid,
      int streakBonusPoints,
      bool streakBonus,
      int playingRound,
      int streakBonusRounds) {
    if (result == bid) {
      score += result + 5;
      if (playingRound != 1) {
        roundsWon++;
        roundsLost = 0;
      }
    } else {
      score -= (result - bid).abs();
      if (playingRound != 1) {
        roundsLost++;
        roundsWon = 0;
      }
    }
    if (streakBonus && playingRound != 1) {
      // daca este activat
      if (roundsWon == streakBonusRounds) {
        score += streakBonusPoints;
        print("!!!!!!!!!S-a premiaaat pe plus!!!!!!!!!");
        roundsWon = 0;
      }
      if (roundsLost == streakBonusRounds) {
        score -= streakBonusPoints;
        print("!!!!!!!!!S-a premiaaat pe minus!!!!!!!!!");
        roundsLost = 0;
      }
    }
  }
}
