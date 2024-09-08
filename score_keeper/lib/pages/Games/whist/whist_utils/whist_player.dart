class Player {
  late List<int> betRounds = [];
  late List<int> resultRounds = [];
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

  void updateBetRounds(int bet, bool replace) {
    if (!replace) {
      // if is false this means i have to add
      betRounds.add(bet);
      return;
    }
    betRounds.removeLast();
    betRounds.add(bet);
  }

  void updateResultRounds(int result, bool replace) {
    if (!replace) {
      resultRounds.add(result);
      return;
    }
    resultRounds.removeLast();
    resultRounds.add(result);
  }

  void eraseLastBet() {
    if (betRounds.isNotEmpty) {
      betRounds.removeLast();
    }
  }

  void eraseLastResult() {
    if (resultRounds.isNotEmpty) {
      resultRounds.removeLast();
    }
  }

  void calculateScore(int streakBonusPoints, bool streakBonus, int playingRound,
      int streakBonusRounds) {
    score = 0;
    if (resultRounds.isEmpty) {
      return;
    }
    for (int i = 0; i < resultRounds.length; i++) {
      // i traverse the results list because it will always smaller than the bids list
      int result = resultRounds[i];
      int bid = betRounds[i];
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
          roundsWon = 0;
        }
        if (roundsLost == streakBonusRounds) {
          score -= streakBonusPoints;
          roundsLost = 0;
        }
      }
    }
  }
}
