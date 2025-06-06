import 'dart:math';

import 'package:flutter/material.dart';
import 'package:french_exercises/screens/header.dart';

/// Main widget for the French “Grands Nombres” Game
class A1Twelve extends StatefulWidget {
  final String imageUrl;
  const A1Twelve({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1TwelveState createState() => _A1TwelveState();
}

class _A1TwelveState extends State<A1Twelve> {
  /// Dictionnaire des « grands nombres » en français (orthographe rectifiée de 1990)
  /// — utilisé pour générer les questions et vérifier les réponses.
  final Map<int, String> _grandsNombresFr = const {
    // -------- CENTAINES (100–999) --------
    100: "cent",
    101: "cent-un",
    110: "cent-dix",
    115: "cent-quinze",
    120: "cent-vingt",
    121: "cent-vingt-et-un",
    130: "cent-trente",
    140: "cent-quarante",
    150: "cent-cinquante",
    160: "cent-soixante",
    170: "cent-soixante-dix",
    180: "cent-quatre-vingts",
    190: "cent-quatre-vingt-dix",
    199: "cent-quatre-vingt-dix-neuf",

    200: "deux-cents",
    201: "deux-cents-un",
    202: "deux-cents-deux",
    210: "deux-cents-dix",
    225: "deux-cents-vingt-cinq",
    250: "deux-cents-cinquante",
    275: "deux-cents-soixante-quinze",
    299: "deux-cents-quatre-vingt-dix-neuf",

    300: "trois-cents",
    301: "trois-cents-un",
    333: "trois-cent-trente-trois",
    350: "trois-cents-cinquante",
    399: "trois-cents-quatre-vingt-dix-neuf",

    400: "quatre-cents",
    404: "quatre-cent-quatre",
    444: "quatre-cent-quarante-quatre",
    475: "quatre-cents-soixante-quinze",
    499: "quatre-cents-quatre-vingt-dix-neuf",

    500: "cinq-cents",
    505: "cinq-cents-cinq",
    550: "cinq-cents-cinquante",
    555: "cinq-cent-cinquante-cinq",
    599: "cinq-cents-quatre-vingt-dix-neuf",

    600: "six-cents",
    606: "six-cents-six",
    650: "six-cents-cinquante",
    666: "six-cent-soixante-six",
    699: "six-cents-quatre-vingt-dix-neuf",

    700: "sept-cents",
    707: "sept-cents-sept",
    750: "sept-cents-cinquante",
    777: "sept-cent-soixante-dix-sept",
    799: "sept-cents-quatre-vingt-dix-neuf",

    800: "huit-cents",
    808: "huit-cents-huit",
    850: "huit-cents-cinquante",
    888: "huit-cent-quatre-vingt-huit",
    899: "huit-cents-quatre-vingt-dix-neuf",

    900: "neuf-cents",
    909: "neuf-cents-neuf",
    950: "neuf-cents-cinquante",
    999: "neuf-cent-quatre-vingt-dix-neuf",

    // -------- MILLE (1 000–9 999) --------
    1000: "mille",
    1001: "mille-un",
    1010: "mille-dix",
    1100: "mille-cent",
    1111: "mille-cent-onze",
    1500: "mille-cinq-cents",
    1999: "mille-neuf-cent-quatre-vingt-dix-neuf",

    2000: "deux-mille",
    2002: "deux-mille-deux",
    2020: "deux-mille-vingt",
    2250: "deux-mille-deux-cents-cinquante",
    2500: "deux-mille-cinq-cents",
    2999: "deux-mille-neuf-cent-quatre-vingt-dix-neuf",

    3000: "trois-mille",
    3333: "trois-mille-trois-cent-trente-trois",
    3500: "trois-mille-cinq-cents",
    3999: "trois-mille-neuf-cent-quatre-vingt-dix-neuf",

    4000: "quatre-mille",
    4444: "quatre-mille-quatre-cent-quarante-quatre",
    4500: "quatre-mille-cinq-cents",
    4999: "quatre-mille-neuf-cent-quatre-vingt-dix-neuf",

    5000: "cinq-mille",
    5555: "cinq-mille-cinq-cent-cinquante-cinq",
    5750: "cinq-mille-sept-cent-cinquante",
    5999: "cinq-mille-neuf-cent-quatre-vingt-dix-neuf",

    6000: "six-mille",
    6666: "six-mille-six-cent-soixante-six",
    6500: "six-mille-cinq-cents",
    6999: "six-mille-neuf-cent-quatre-vingt-dix-neuf",

    7000: "sept-mille",
    7777: "sept-mille-sept-cent-soixante-dix-sept",
    7500: "sept-mille-cinq-cents",
    7999: "sept-mille-neuf-cent-quatre-vingt-dix-neuf",

    8000: "huit-mille",
    8888: "huit-mille-huit-cent-quatre-vingt-huit",
    8500: "huit-mille-cinq-cents",
    8999: "huit-mille-neuf-cent-quatre-vingt-dix-neuf",

    9000: "neuf-mille",
    9999: "neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- DIZAINES DE MILLIERS (10 000–99 999) --------
    10000: "dix-mille",
    11000: "onze-mille",
    15000: "quinze-mille",
    19999: "dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    20000: "vingt-mille",
    22000: "vingt-deux-mille",
    25000: "vingt-cinq-mille",
    29999: "vingt-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    30000: "trente-mille",
    33333: "trente-trois-mille-trois-cent-trente-trois",
    35000: "trente-cinq-mille",
    39999: "trente-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    40000: "quarante-mille",
    44444: "quarante-quatre-mille-quatre-cent-quarante-quatre",
    45000: "quarante-cinq-mille",
    49999: "quarante-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    50000: "cinquante-mille",
    55555: "cinquante-cinq-mille-cinq-cent-cinquante-cinq",
    57500: "cinquante-sept-mille-cinq-cents",
    59999: "cinquante-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    60000: "soixante-mille",
    66666: "soixante-six-mille-six-cent-soixante-six",
    65000: "soixante-cinq-mille",
    69999: "soixante-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    70000: "soixante-dix-mille",
    77777: "soixante-dix-sept-mille-sept-cent-soixante-dix-sept",
    75000: "soixante-quinze-mille",
    79999: "soixante-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    80000: "quatre-vingt-mille",
    88888: "quatre-vingt-huit-mille-huit-cent-quatre-vingt-huit",
    85000: "quatre-vingt-cinq-mille",
    89999: "quatre-vingt-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    90000: "quatre-vingt-dix-mille",
    99999: "quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- CENTAINES DE MILLIERS (100 000–999 999) --------
    100000: "cent-mille",
    101000: "cent-un-mille",
    110000: "cent-dix-mille",
    150000: "cent-cinquante-mille",
    199999: "cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    200000: "deux-cents-mille",
    201000: "deux-cents-un-mille",
    225000: "deux-cents-vingt-cinq-mille",
    299999:
        "deux-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    300000: "trois-cents-mille",
    305000: "trois-cents-cinq-mille",
    333333: "trois-cent-trente-trois-mille-trois-cent-trente-trois",
    399999:
        "trois-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    400000: "quatre-cents-mille",
    444444: "quatre-cent-quarante-quatre-mille-quatre-cent-quarante-quatre",
    450000: "quatre-cents-cinquante-mille",
    499999:
        "quatre-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    500000: "cinq-cents-mille",
    555555: "cinq-cent-cinquante-cinq-mille-cinq-cent-cinquante-cinq",
    575000: "cinq-cents-soixante-quinze-mille",
    599999:
        "cinq-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    600000: "six-cents-mille",
    666666: "six-cent-soixante-six-mille-six-cent-soixante-six",
    650000: "six-cents-cinquante-mille",
    699999:
        "six-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    700000: "sept-cents-mille",
    777777: "sept-cent-soixante-dix-sept-mille-sept-cent-soixante-dix-sept",
    750000: "sept-cents-cinquante-mille",
    799999:
        "sept-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    800000: "huit-cents-mille",
    888888: "huit-cent-quatre-vingt-huit-mille-huit-cent-quatre-vingt-huit",
    850000: "huit-cents-cinquante-mille",
    899999:
        "huit-cents-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    900000: "neuf-cents-mille",
    999999:
        "neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- MILLIONS (1 000 000–999 999 999) --------
    1000000: "un-million",
    1000001: "un-million-un",
    1010000: "un-million-dix-mille",
    1100000: "un-million-cent-mille",
    1500000: "un-million-cinq-cent-mille",
    1999999:
        "un-million-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    2000000: "deux-millions",
    2020202: "deux-millions-vingt-mille-deux-cent-deux",
    2500000: "deux-millions-cinq-cent-mille",
    2999999:
        "deux-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    3000000: "trois-millions",
    3333333:
        "trois-millions-trois-cent-trente-trois-mille-trois-cent-trente-trois",
    3500000: "trois-millions-cinq-cent-mille",
    3999999:
        "trois-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    4000000: "quatre-millions",
    4444444:
        "quatre-millions-quatre-cent-quarante-quatre-mille-quatre-cent-quarante-quatre",
    4500000: "quatre-millions-cinq-cent-mille",
    4999999:
        "quatre-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    5000000: "cinq-millions",
    5555555:
        "cinq-millions-cinq-cent-cinquante-cinq-mille-cinq-cent-cinquante-cinq",
    5750000: "cinq-millions-sept-cent-cinquante-mille",
    5999999:
        "cinq-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    6000000: "six-millions",
    6666666: "six-millions-six-cent-soixante-six-mille-six-cent-soixante-six",
    6500000: "six-millions-cinq-cent-mille",
    6999999:
        "six-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    7000000: "sept-millions",
    7777777:
        "sept-millions-sept-cent-soixante-dix-sept-mille-sept-cent-soixante-dix-sept",
    7500000: "sept-millions-cinq-cent-mille",
    7999999:
        "sept-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    8000000: "huit-millions",
    8888888:
        "huit-millions-huit-cent-quatre-vingt-huit-mille-huit-cent-quatre-vingt-huit",
    8500000: "huit-millions-cinq-cent-mille",
    8999999:
        "huit-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    9000000: "neuf-millions",
    9999999:
        "neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    10000000: "dix-millions",
    20202020: "vingt-millions-deux-cent-deux-mille-vingt",
    50000000: "cinquante-millions",
    100000000: "cent-millions",
    200000000: "deux-cents-millions",
    500000000: "cinq-cents-millions",
    999999999:
        "neuf-cent-quatre-vingt-dix-neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- MILLIARDS (1 000 000 000–9 999 999 999) --------
    1000000000: "un-milliard",
    1000000001: "un-milliard-un",
    1500000000: "un-milliard-cinq-cents-millions",
    2000000000: "deux-milliards",
    2020202020: "deux-milliards-vingt-millions-deux-cent-vingt-mille-vingt",
    2500000000: "deux-milliards-cinq-cents-millions",
    3000000000: "trois-milliards",
    5000000000: "cinq-milliards",
    9999999999:
        "neuf-milliards-neuf-cent-quatre-vingt-dix-neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- DIXIÈMES DE MILLIARD (10 000 000 000–99 999 999 999) --------
    10000000000: "dix-milliards",
    15000000000: "quinze-milliards",
    20000000000: "vingt-milliards",
    50000000000: "cinquante-milliards",
    99999999999:
        "quatre-vingt-dix-neuf-milliards-neuf-cent-quatre-vingt-dix-neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- CENTAINES DE MILLIARD (100 000 000 000–999 999 999 999) --------
    100000000000: "cent-milliards",
    150000000000: "cent-cinquante-milliards",
    200000000000: "deux-cents-milliards",
    500000000000: "cinq-cents-milliards",
    999999999999:
        "neuf-cent-quatre-vingt-dix-neuf-milliards-neuf-cent-quatre-vingt-dix-neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",

    // -------- BILLIONS (1 000 000 000 000 = 10^12) --------
    1000000000000: "un-billion",
    1500000000000: "un-billion-cinq-cents-milliards",
    2000000000000: "deux-billions",
    5000000000000: "cinq-billions",
    9999999999999:
        "neuf-mille-neuf-cent-quatre-vingt-dix-neuf-billions-neuf-cent-quatre-vingt-dix-neuf-milliards-neuf-cent-quatre-vingt-dix-neuf-millions-neuf-cent-quatre-vingt-dix-neuf-mille-neuf-cent-quatre-vingt-dix-neuf",
  };

  int _score = 0;
  int _totalQuestions = 0;
  int? _currentKey;
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

  /// Retourne un index aléatoire entre [min] et [max], inclus.
  int _getRandomInt(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  /// Génére quatre choix (dont le bon), retournés sous forme de liste mélangée.
  List<int> _generateChoices(int correctKey) {
    final allKeys = _grandsNombresFr.keys.toList();
    final choicesSet = <int>{correctKey};

    while (choicesSet.length < 4) {
      final randomKey = allKeys[_getRandomInt(0, allKeys.length - 1)];
      choicesSet.add(randomKey);
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

      // Choisit aléatoirement une clé parmi les « grands nombres »
      final keysList = _grandsNombresFr.keys.toList();
      _currentKey = keysList[_getRandomInt(0, keysList.length - 1)];
      _options = _generateChoices(_currentKey!);
    });
  }

  void _checkAnswer(int selectedKey) {
    setState(() {
      _answered = true;
      if (selectedKey == _currentKey) {
        _feedbackText = "✅ Exact ! Bien joué.";
        _score++;
      } else {
        final correctText = _grandsNombresFr[_currentKey]!;
        _feedbackText = "❌ Raté… La bonne réponse était « $correctText ».";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F4), // #fbf9f4
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GameHeader(imageUrl: widget.imageUrl, heroTag: widget.imageUrl),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 220),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white, // #ffffff
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
                          // Titre
                          const Text(
                            'Apprends les grands nombres !',
                            style: TextStyle(
                              fontSize: 24, // proche de 1.8rem
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF34495E), // #34495e
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),

                          // Description
                          const Text(
                            'Pour chaque nombre, choisis la bonne écriture française parmi les propositions.',
                            style: TextStyle(
                              fontSize: 14, // proche de 0.9rem
                              color: Color(0xFF555555), // #555
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          // Affichage du nombre à deviner
                          Text(
                            _currentKey?.toString() ?? '—',
                            style: const TextStyle(
                              fontSize: 48, // proche de 2.5rem
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE74C3C), // #e74c3c
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Grille de choix (2 colonnes)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _options.length,

                            itemBuilder: (context, index) {
                              final key = _options[index];
                              final isDisabled = _answered;
                              return GestureDetector(
                                onTap:
                                    isDisabled ? null : () => _checkAnswer(key),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        _grandsNombresFr[key]!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),

                          // Feedback (message après réponse)
                          Text(
                            _feedbackText,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF555555), // #555
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          // Affichage du score
                          Text(
                            'Score : $_score / $_totalQuestions',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50), // #2c3e50
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Bouton « Question suivante »
                          ElevatedButton(
                            onPressed: _answered ? _nextQuestion : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _answered
                                      ? const Color(0xFF27AE60) // #27ae60
                                      : const Color(0xFF95A5A6), // #95a5a6
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
