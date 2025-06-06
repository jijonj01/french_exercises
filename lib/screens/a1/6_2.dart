import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A Flutter implementation of the “Fractions de l’heure en français” game.
/// Converted from the provided HTML/CSS/JS into a StatefulWidget named A1Fourteen.
class A1Fourteen extends StatefulWidget {
  const A1Fourteen({Key? key}) : super(key: key);

  @override
  _A1FourteenState createState() => _A1FourteenState();
}

class _A1FourteenState extends State<A1Fourteen> {
  // === State for the game logic ===
  int _correctCount = 0;
  int _totalCount = 0;

  // Current time values for the “digital clock”
  late int _hour12;
  late int _minute;
  late String _ampm;

  // The correct French phrase for the current time
  String _currentAnswer = '';

  // The shuffled options (1 correct + 3 distractors)
  List<String> _options = [];

  // Feedback text and color after selecting an answer
  String _feedbackText = '';
  Color _feedbackColor = Colors.black;

  // Whether the user has already answered the current round
  bool _answered = false;

  // Controls visibility of the “Suivant ▶” button
  bool _showNextButton = false;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startNewRound();
  }

  /// Maps integers 0–12 to their French words.
  String _numberToFrench(int n) {
    const uniques = <int, String>{
      0: 'zéro',
      1: 'un',
      2: 'deux',
      3: 'trois',
      4: 'quatre',
      5: 'cinq',
      6: 'six',
      7: 'sept',
      8: 'huit',
      9: 'neuf',
      10: 'dix',
      11: 'onze',
      12: 'douze',
    };
    if (n <= 12 && uniques.containsKey(n)) {
      return uniques[n]!;
    }
    return '';
  }

  /// Returns “du matin”, “de l’après-midi”, or “du soir” based on hour and AM/PM.
  String _periodText(int h12, String ampm) {
    if (ampm == 'AM') {
      return 'du matin';
    } else {
      // PM
      if (h12 >= 4) {
        return 'du soir';
      }
      return "de l'après-midi";
    }
  }

  /// Constructs the French phrase for a time that is either :15, :30, or :45.
  String _timeToFrenchFraction(int h12, int minute, String ampm) {
    // For hour = 1, use “une”; otherwise use the number.
    final hourText = (h12 == 1) ? 'une' : _numberToFrench(h12);
    final period = _periodText(h12, ampm);

    if (minute == 15) {
      return 'Il est $hourText heures et quart $period';
    }
    if (minute == 30) {
      return 'Il est $hourText heures et demie $period';
    }
    if (minute == 45) {
      // For “moins le quart”, advance to next hour.
      final nextHour = (h12 == 12) ? 1 : h12 + 1;
      final nextHourText = (nextHour == 1) ? 'une' : _numberToFrench(nextHour);
      return 'Il est $nextHourText heures moins le quart $period';
    }
    return '';
  }

  /// Picks a random hour (1–12), a random minute among {15, 30, 45}, and random AM/PM.
  Map<String, dynamic> _randomTimeFraction() {
    final hour12 = _random.nextInt(12) + 1; // 1..12
    const fractions = [15, 30, 45];
    final minute = fractions[_random.nextInt(fractions.length)];
    final ampm = (_random.nextBool()) ? 'AM' : 'PM';
    return {'hour12': hour12, 'minute': minute, 'ampm': ampm};
  }

  /// Formats the time into a digital display string like “4 :15 PM”.
  String _formatDigitalTime(int h12, int minute, String ampm) {
    final mm = minute.toString().padLeft(2, '0');
    return '$h12 :$mm $ampm';
  }

  /// Initializes a new round: resets feedback, hides Next button, picks a random time,
  /// computes the correct answer, creates three distractors, shuffles options, and updates state.
  void _startNewRound() {
    setState(() {
      _answered = false;
      _showNextButton = false;
      _feedbackText = '';

      // 1) Pick a new random time
      final time = _randomTimeFraction();
      _hour12 = time['hour12'] as int;
      _minute = time['minute'] as int;
      _ampm = time['ampm'] as String;

      // 2) Compute the correct French phrase
      _currentAnswer = _timeToFrenchFraction(_hour12, _minute, _ampm);

      // 3) Build a Set of 4 unique phrases (1 correct + 3 random distractors)
      final allChoices = <String>{};
      allChoices.add(_currentAnswer);

      while (allChoices.length < 4) {
        final altTime = _randomTimeFraction();
        final phrase2 = _timeToFrenchFraction(
          altTime['hour12'] as int,
          altTime['minute'] as int,
          altTime['ampm'] as String,
        );
        if (phrase2.isNotEmpty && !allChoices.contains(phrase2)) {
          allChoices.add(phrase2);
        }
      }

      // 4) Shuffle the 4 options
      _options = allChoices.toList()..shuffle(_random);
    });
  }

  /// Called when the user taps one of the option buttons.
  void _checkAnswer(String selected) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _totalCount++;
      if (selected == _currentAnswer) {
        _correctCount++;
        _feedbackText = '✅ Bravo ! C’est correct.';
        _feedbackColor = const Color(0xFF28A745);
      } else {
        _feedbackText = '❌ Oups… la bonne réponse était : « $_currentAnswer ».';
        _feedbackColor = const Color(0xFFC82333);
      }
      _showNextButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  // === Header ===
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF444444),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: const [
                        Text(
                          'Fractions de l’heure en français',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Devine l’expression correcte pour l’heure indiquée',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // === Main content centered, maxWidth ~500 ===
                  Center(
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Digital Clock Display
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 240,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _formatDigitalTime(_hour12, _minute, _ampm),
                                  style: const TextStyle(
                                    color: Color(0xFF00FF00),
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              // Green dot indicator at bottom-right
                              Positioned(
                                bottom: 6,
                                right: 8,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00FF00),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF00FF00,
                                        ).withOpacity(0.7),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Option Buttons (vertical list with spacing)
                          Column(
                            children:
                                _options.map((text) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed:
                                            _answered
                                                ? null
                                                : () => _checkAnswer(text),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black87,
                                          side: const BorderSide(
                                            color: Color(0xFF444444),
                                            width: 2,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        child: Text(text),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),

                          const SizedBox(height: 16),

                          // Feedback Text
                          SizedBox(
                            height: 24,
                            child: Text(
                              _feedbackText,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _feedbackColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // “Suivant ▶” Button
                          if (_showNextButton)
                            ElevatedButton(
                              onPressed: _startNewRound,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF28A745),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text('Suivant ▶'),
                            ),

                          const SizedBox(height: 24),

                          // Scoreboard
                          Text(
                            'Bonnes réponses : $_correctCount / $_totalCount',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
