import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const MaterialApp(home: A1Thirteen(), debugShowCheckedModeBanner: false),
  );
}

class A1Thirteen extends StatefulWidget {
  const A1Thirteen({Key? key}) : super(key: key);

  @override
  _A1ThirteenState createState() => _A1ThirteenState();
}

class _A1ThirteenState extends State<A1Thirteen> {
  // ====== Game State ======
  int _currentHour = 0;
  int _currentMinute = 0;
  String _currentAnswer = '';
  final List<String> _options = [];
  int _correctCount = 0;
  int _totalCount = 0;
  bool _answered = false;
  String _selectedAnswer = '';

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  /// Generate a random time: hour ∈ [0..23], minute ∈ multiples of 5
  Map<String, int> _randomTime() {
    final rand = Random();
    final h = rand.nextInt(24);
    final m = rand.nextInt(12) * 5;
    return {'h': h, 'm': m};
  }

  /// Convert numbers 0–59 to French words
  String _numberToFrench(int n) {
    const uniques = {
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
      13: 'treize',
      14: 'quatorze',
      15: 'quinze',
      16: 'seize',
    };
    if (n <= 16) return uniques[n]!;
    if (n < 20) return 'dix-${uniques[n - 10]}';
    if (n < 30) {
      if (n == 20) return 'vingt';
      if (n == 21) return 'vingt et un';
      return 'vingt-${uniques[n - 20]}';
    }
    if (n < 40) {
      if (n == 30) return 'trente';
      if (n == 31) return 'trente et un';
      return 'trente-${uniques[n - 30]}';
    }
    if (n < 50) {
      if (n == 40) return 'quarante';
      if (n == 41) return 'quarante et un';
      return 'quarante-${uniques[n - 40]}';
    }
    if (n < 60) {
      if (n == 50) return 'cinquante';
      if (n == 51) return 'cinquante et un';
      return 'cinquante-${uniques[n - 50]}';
    }
    return '';
  }

  /// Convert a given hour (0–23) and minute (0–59) into a French phrase
  String _timeToFrench(int hour, int minute) {
    // Special cases: midnight (0:00) and noon (12:00)
    if (hour == 0 && minute == 0) return 'Il est minuit';
    if (hour == 12 && minute == 0) return 'Il est midi';

    // Convert hour number to French text
    late String hourText;
    if (hour == 1 || hour == 13) {
      hourText = 'une';
    } else if (hour == 0) {
      hourText = 'zéro';
    } else {
      final h = hour % 24;
      hourText = _numberToFrench(h);
    }

    // Decide singular/plural "heure(s)"
    final heureWord = (hour % 24 == 1) ? 'heure' : 'heures';

    // Exactly on the hour
    if (minute == 0) {
      return 'Il est $hourText $heureWord';
    }

    // Half past
    if (minute == 30) {
      return 'Il est $hourText heures trente';
    }

    // Otherwise, "heures et X minutes"
    final minuteText = _numberToFrench(minute);
    return 'Il est $hourText heures et $minuteText minutes';
  }

  /// Start a new round: pick a random time, compute the correct phrase,
  /// generate 3 distractors, shuffle options.
  void _newRound() {
    setState(() {
      _answered = false;
      _selectedAnswer = '';
      _options.clear();

      final randTime = _randomTime();
      _currentHour = randTime['h']!;
      _currentMinute = randTime['m']!;
      _currentAnswer = _timeToFrench(_currentHour, _currentMinute);

      final allChoices = <String>{_currentAnswer};
      while (allChoices.length < 4) {
        final candidate = _randomTime();
        final phrase = _timeToFrench(candidate['h']!, candidate['m']!);
        allChoices.add(phrase);
      }

      _options.addAll(allChoices);
      _options.shuffle();
    });
  }

  /// Handle answer selection
  void _checkAnswer(String selected) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      _totalCount++;
      if (selected == _currentAnswer) {
        _correctCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // ====== Header ======
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF3A3A3A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: const [
                        Text(
                          'Apprends l’heure en français !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Devine l’heure affichée et choisis la bonne phrase',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ====== Analog Clock ======
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: ClockPainter(
                        hour: _currentHour,
                        minute: _currentMinute,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ====== Options ======
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children:
                          _options.map((text) {
                            // Determine button colors based on state
                            Color bgColor = Colors.white;
                            Color fgColor = Colors.black87;
                            // After answering, highlight selected and correct
                            if (_answered) {
                              if (text == _currentAnswer) {
                                bgColor = const Color(0xFF28A745); // green
                                fgColor = Colors.white;
                              } else if (text == _selectedAnswer &&
                                  _selectedAnswer != _currentAnswer) {
                                bgColor = const Color(0xFFC82333); // red
                                fgColor = Colors.white;
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ElevatedButton(
                                onPressed:
                                    _answered ? null : () => _checkAnswer(text),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: bgColor,
                                  foregroundColor: fgColor,
                                  disabledBackgroundColor: bgColor,
                                  disabledForegroundColor: fgColor,
                                  side: const BorderSide(
                                    color: Color(0xFF3A3A3A),
                                    width: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  textStyle: const TextStyle(fontSize: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ====== Feedback ======
                  if (_answered)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Builder(
                        builder: (context) {
                          final isCorrect = _selectedAnswer == _currentAnswer;
                          final feedbackText =
                              isCorrect
                                  ? '✅ Bravo ! C’est correct.'
                                  : '❌ Oups… la bonne réponse était : “$_currentAnswer.”';
                          final feedbackColor =
                              isCorrect
                                  ? const Color(0xFF28A745)
                                  : const Color(0xFFC82333);
                          return Text(
                            feedbackText,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: feedbackColor,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),

                  // ====== Next Button ======
                  if (_answered)
                    ElevatedButton(
                      onPressed: _newRound,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28A745),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text('Suivant ▶'),
                    ),
                  const SizedBox(height: 24),

                  // ====== Scoreboard ======
                  Text(
                    'Bonne réponses : $_correctCount / $_totalCount',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 24),
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

/// Painter for drawing an analog clock face at a specified [hour] and [minute].
class ClockPainter extends CustomPainter {
  final int hour;
  final int minute;

  ClockPainter({required this.hour, required this.minute});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer circle
    final circlePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 5, circlePaint);

    final borderPaint =
        Paint()
          ..color = const Color(0xFF333333)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8;
    canvas.drawCircle(center, radius - 5, borderPaint);

    // Translate to center for ticks and numbers
    canvas.translate(center.dx, center.dy);

    // Draw hour numbers
    for (int num = 1; num <= 12; num++) {
      final angle = (num * pi) / 6;
      canvas.save();
      canvas.rotate(angle);
      // Position number at radius - 30
      final textPainter = TextPainter(
        text: TextSpan(
          text: num.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      canvas.save();
      canvas.translate(0, -radius + 30);
      canvas.rotate(-angle);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
      canvas.restore();
    }

    // Draw minute ticks
    for (int i = 0; i < 60; i++) {
      final isHourTick = i % 5 == 0;
      final tickLen = isHourTick ? 10.0 : 5.0;
      final tickWidth = isHourTick ? 3.0 : 1.0;
      final tickPaint =
          Paint()
            ..color = Colors.black
            ..strokeWidth = tickWidth
            ..strokeCap = StrokeCap.round;
      canvas.save();
      final angle = (i * 2 * pi) / 60;
      canvas.rotate(angle);
      canvas.drawLine(
        Offset(0, -radius + 5),
        Offset(0, -radius + 5 + tickLen),
        tickPaint,
      );
      canvas.restore();
    }

    // Draw hour hand
    final hourAngle =
        ((hour % 12) * pi) / 6 +
        (minute * pi) / (6 * 60); // plus a small fraction for smoothness
    final hourHandPaint =
        Paint()
          ..color = const Color(0xFF333333)
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.rotate(hourAngle);
    canvas.drawLine(Offset(0, 0), Offset(0, -radius * 0.5), hourHandPaint);
    canvas.restore();

    // Draw minute hand
    final minuteAngle = (minute * pi) / 30;
    final minuteHandPaint =
        Paint()
          ..color = const Color(0xFF555555)
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.rotate(minuteAngle);
    canvas.drawLine(Offset(0, 0), Offset(0, -radius * 0.75), minuteHandPaint);
    canvas.restore();

    // Draw center dot
    final centerDotPaint = Paint()..color = Colors.black;
    canvas.drawCircle(const Offset(0, 0), 5, centerDotPaint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.hour != hour || oldDelegate.minute != minute;
  }
}
