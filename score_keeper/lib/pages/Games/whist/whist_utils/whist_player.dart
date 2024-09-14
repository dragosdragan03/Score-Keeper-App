import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';

class Player {
  late List<int> betRounds = [];
  late List<int> resultRounds = [];
  late List<int> scoreRounds = [];
  String name;
  int score;

  Player({
    required this.name,
    required this.score,
  });

  // void updateBetRounds(int bet, bool replace) {
  //   if (!replace) {
  //     // if is false this means i have to add
  //     betRounds.add(bet);
  //     return;
  //   }
  //   eraseLastBet();
  //   betRounds.add(bet);
  // }

  // void updateResultRounds(int result, bool replace) {
  //   if (!replace) {
  //     resultRounds.add(result);
  //     return;
  //   }
  //   eraseLastResult();
  //   resultRounds.add(result);
  // }

  void addBetRound(int bet) {
    betRounds.add(bet);
  }

  void addResultRound(int result) {
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

  void eraseLastScore() {
    if (scoreRounds.isNotEmpty) {
      scoreRounds.removeLast();
    }
  }

  void calculateScore(
      bool lastSum,
      int streakBonusRounds,
      int streakBonusPoints,
      bool streakBonus,
      int numberOfPlayers,
      bool gameType) {
    // bool lastSum = gameProvider.lastSum;
    // int streakBonusRounds = gameProvider.streakBonusRounds;
    // int streakBonusPoints = gameProvider.streakBonusPoints;
    // bool streakBonus = gameProvider.streakBonus;
    int sumOfLastRounds = 0;
    int scoreBuilder = 0;
    int roundsWon = 0;
    int roundsLost = 0;

    print("////////////////////////${name}////////////////////////////////");
    print("");

    print("streakBonusRounds: $streakBonusRounds");

    // score = 0;
    // if (resultRounds.isEmpty) {
    //   scoreRounds.add(score);
    //   return;
    // }

    for (int i = 0; i < resultRounds.length; i++) {
      // i traverse the results list because it will always smaller than the bids list

      print("i: $i");
      print("sumOfLastRounds: $sumOfLastRounds");
      print("scoreBuilder: $scoreBuilder");
      double aux =
          GameProviderWhist.rnToPrDotIndex(i + 1, numberOfPlayers, gameType);
      print("aux: $aux");
      int result = resultRounds[i];
      int bid = betRounds[i];
      if (result == bid) {
        scoreBuilder += result + 5;
        if (aux.floor() != 1) {
          roundsWon++;
          sumOfLastRounds += bid;
          roundsLost = 0;
        }
      } else {
        scoreBuilder -= (result - bid).abs();
        if (aux.floor() != 1) {
          roundsLost++;
          roundsWon = 0;
          sumOfLastRounds = 0;
        }
      }
      if (streakBonus && aux.floor() != 1) {
        // daca este activat
        if (lastSum) {
          if (roundsWon >= streakBonusRounds) {
            if (sumOfLastRounds > 0) {
              scoreBuilder += streakBonusPoints;
              sumOfLastRounds = 0;
              roundsWon = 0;
            }
          }
        } else {
          if (roundsWon == streakBonusRounds) {
            scoreBuilder += streakBonusPoints;
            roundsWon = 0;
          }
        }
        if (roundsLost == streakBonusRounds) {
          scoreBuilder -= streakBonusPoints;
          roundsLost = 0;
        }
      }
    }
    print("added: $scoreBuilder");
    scoreRounds.add(scoreBuilder);
    print("whist_player.dart: $scoreRounds");
    score = scoreBuilder;
  }
}
