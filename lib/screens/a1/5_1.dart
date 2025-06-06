import 'dart:math';

import 'package:flutter/material.dart';
import 'package:french_exercises/screens/header.dart';

/// Main widget for the French Counting Game
class A1Eleven extends StatefulWidget {
  final String imageUrl;
  const A1Eleven({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1ElevenState createState() => _A1ElevenState();
}

class _A1ElevenState extends State<A1Eleven> {
  // Dictionary of numbers from 0 to 99 in French
  final Map<int, String> _nombreFr = const {
    0: "zéro",
    1: "un",
    2: "deux",
    3: "trois",
    4: "quatre",
    5: "cinq",
    6: "six",
    7: "sept",
    8: "huit",
    9: "neuf",
    10: "dix",
    11: "onze",
    12: "douze",
    13: "treize",
    14: "quatorze",
    15: "quinze",
    16: "seize",
    17: "dix-sept",
    18: "dix-huit",
    19: "dix-neuf",
    20: "vingt",
    21: "vingt-et-un",
    22: "vingt-deux",
    23: "vingt-trois",
    24: "vingt-quatre",
    25: "vingt-cinq",
    26: "vingt-six",
    27: "vingt-sept",
    28: "vingt-huit",
    29: "vingt-neuf",
    30: "trente",
    31: "trente-et-un",
    32: "trente-deux",
    33: "trente-trois",
    34: "trente-quatre",
    35: "trente-cinq",
    36: "trente-six",
    37: "trente-sept",
    38: "trente-huit",
    39: "trente-neuf",
    40: "quarante",
    41: "quarante-et-un",
    42: "quarante-deux",
    43: "quarante-trois",
    44: "quarante-quatre",
    45: "quarante-cinq",
    46: "quarante-six",
    47: "quarante-sept",
    48: "quarante-huit",
    49: "quarante-neuf",
    50: "cinquante",
    51: "cinquante-et-un",
    52: "cinquante-deux",
    53: "cinquante-trois",
    54: "cinquante-quatre",
    55: "cinquante-cinq",
    56: "cinquante-six",
    57: "cinquante-sept",
    58: "cinquante-huit",
    59: "cinquante-neuf",
    60: "soixante",
    61: "soixante-et-un",
    62: "soixante-deux",
    63: "soixante-trois",
    64: "soixante-quatre",
    65: "soixante-cinq",
    66: "soixante-six",
    67: "soixante-sept",
    68: "soixante-huit",
    69: "soixante-neuf",
    70: "soixante-dix",
    71: "soixante-et-onze",
    72: "soixante-douze",
    73: "soixante-treize",
    74: "soixante-quatorze",
    75: "soixante-quinze",
    76: "soixante-seize",
    77: "soixante-dix-sept",
    78: "soixante-dix-huit",
    79: "soixante-dix-neuf",
    80: "quatre-vingts",
    81: "quatre-vingt-un",
    82: "quatre-vingt-deux",
    83: "quatre-vingt-trois",
    84: "quatre-vingt-quatre",
    85: "quatre-vingt-cinq",
    86: "quatre-vingt-six",
    87: "quatre-vingt-sept",
    88: "quatre-vingt-huit",
    89: "quatre-vingt-neuf",
    90: "quatre-vingt-dix",
    91: "quatre-vingt-onze",
    92: "quatre-vingt-douze",
    93: "quatre-vingt-treize",
    94: "quatre-vingt-quatorze",
    95: "quatre-vingt-quinze",
    96: "quatre-vingt-seize",
    97: "quatre-vingt-dix-sept",
    98: "quatre-vingt-dix-huit",
    99: "quatre-vingt-dix-neuf",
  };

  int _score = 0;
  int _totalQuestions = 0;
  int? _currentNumber;
  List<int> _options = [];
  String _feedbackText = "";
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    _score = 0;
    _totalQuestions = 0;
    _nextQuestion();
  }

  int _getRandomInt(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  List<int> _generateChoices(int correctNum) {
    final allNumbers = _nombreFr.keys.toList();
    final choicesSet = <int>{correctNum};

    while (choicesSet.length < 4) {
      final randomNum = allNumbers[_getRandomInt(0, allNumbers.length - 1)];
      choicesSet.add(randomNum);
    }

    final choicesList = choicesSet.toList();
    choicesList.shuffle();
    return choicesList;
  }

  void _nextQuestion() {
    setState(() {
      _feedbackText = "";
      _answered = false;
      _totalQuestions++;

      _currentNumber = _getRandomInt(0, 99);
      _options = _generateChoices(_currentNumber!);
    });
  }

  void _checkAnswer(int selectedNum) {
    setState(() {
      _answered = true;
      if (selectedNum == _currentNumber) {
        _feedbackText = "✅ Correct ! Bravo !";
        _score++;
      } else {
        _feedbackText =
            "❌ Faux ! La bonne réponse est « ${_nombreFr[_currentNumber]!} ».";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GameHeader(imageUrl: widget.imageUrl, heroTag: widget.imageUrl),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 220),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 480),
                        margin: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title
                            const Text(
                              'Jeu de comptage en français',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C3E50),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),

                            // Question Area
                            Column(
                              children: [
                                const Text(
                                  'Choisissez la bonne traduction pour le nombre suivant :',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _currentNumber?.toString() ?? "--",
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE74C3C),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Choices Grid
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              children:
                                  _options.map((num) {
                                    final isDisabled = _answered;
                                    return ElevatedButton(
                                      onPressed:
                                          isDisabled
                                              ? null
                                              : () => _checkAnswer(num),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            isDisabled
                                                ? const Color(0xFF95A5A6)
                                                : const Color(0xFF3498DB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      child: Text(
                                        _nombreFr[num]!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                            const SizedBox(height: 20),

                            // Feedback Text
                            Text(
                              _feedbackText,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF333333),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),

                            // Score Display
                            Text(
                              'Score : $_score / $_totalQuestions',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Next Button
                            ElevatedButton(
                              onPressed: _answered ? _nextQuestion : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _answered
                                        ? const Color(0xFF27AE60)
                                        : const Color(0xFF95A5A6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                              ),
                              child: const Text(
                                'Question suivante',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
