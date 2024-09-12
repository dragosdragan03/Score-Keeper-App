import 'package:score_keeper/pages/Games/whist/whist_utils/game_provider_whist.dart';

class Player {
  late List<int> betRounds = [];
  late List<int> resultRounds = [];
  late List<int> scoreRounds = [];
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
    eraseLastBet();
    betRounds.add(bet);
  }

  void updateResultRounds(int result, bool replace) {
    if (!replace) {
      resultRounds.add(result);
      return;
    }
    eraseLastResult();
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
      scoreRounds.removeLast();
    }
  }

  void calculateScore(GameProviderWhist gameProvider) {
    bool lastSum = gameProvider.lastSum;
    int streakBonusRounds = gameProvider.streakBonusRounds;
    int streakBonusPoints = gameProvider.streakBonusPoints;
    bool streakBonus = gameProvider.streakBonus;
    int sumOfLastRounds = 0;

    score = 0;
    if (resultRounds.isEmpty) {
      scoreRounds.add(score);
      return;
    }

    for (int i = 0; i < resultRounds.length; i++) {
      // i traverse the results list because it will always smaller than the bids list
      double aux =  gameProvider.rnToPrDotIndex(i + 1);
      print(aux);
      int result = resultRounds[i];
      int bid = betRounds[i];
      if (result == bid) {
        score += result + 5;
        if (aux.floor() != 1) {
          roundsWon++;
          sumOfLastRounds += bid;
          roundsLost = 0;
        }        
      } else {
        score -= (result - bid).abs();
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
              score += streakBonusPoints;
              sumOfLastRounds = 0;
              roundsWon = 0;
            }
          }
        } else {
          if (roundsWon == streakBonusRounds) {
            score += streakBonusPoints;
            roundsWon = 0;
          }
        }
        if (roundsLost == streakBonusRounds) {
          score -= streakBonusPoints;
          roundsLost = 0;
        }
      }
    }
    scoreRounds.add(score);
  }
}
