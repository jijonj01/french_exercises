import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:go_router/go_router.dart'; // add confetti dependency

class A1Nineteen extends StatefulWidget {
  @override
  _A1NineteenState createState() => _A1NineteenState();
}

class _A1NineteenState extends State<A1Nineteen> {
  final List<String> _options = [
    'française',
    'allemand',
    'chilien',
    'suédoise',
    'indien',
    'grecque',
    'chinois',
  ];

  final List<_Sentence> _sentences = [
    _Sentence(
      text: "a. Bonjour ! Je m’appelle Chen. Je suis ",
      answer: 'chinois',
    ),
    _Sentence(
      text: "b. Salut ! Moi, c’est Markus. Je viens de Berlin, je suis ",
      answer: 'allemand',
    ),
    _Sentence(
      text:
          "c. Elle s’appelle Alexia, elle a 30 ans. Elle habite à Patras, elle est ",
      answer: 'grecque',
    ),
    _Sentence(
      text: "d. Alejandro ? Il habite à Santiago, il est ",
      answer: 'chilien',
    ),
    _Sentence(
      text: "e. Britta vient de Stockholm, elle est ",
      answer: 'suédoise',
    ),
    _Sentence(
      text: "f. Prem travaille à New Delhi. Il a 28 ans, il est ",
      answer: 'indien',
    ),
  ];

  // track which sentences are filled
  final Map<int, String> _placed = {};
  int _score = 0;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onAccept(int idx, String option) {
    if (_sentences[idx].answer == option && !_placed.containsKey(idx)) {
      setState(() {
        _placed[idx] = option;
        _score++;
      });
      _confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative gradient + patterns
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade50, Colors.teal.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Score display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Score: $_score / ${_sentences.length}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[900],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Sentence list with blanks
                  Expanded(
                    child: ListView.builder(
                      itemCount: _sentences.length,
                      itemBuilder: (context, idx) {
                        final sent = _sentences[idx];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  sent.text,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DragTarget<String>(
                                builder: (context, candidate, rejected) {
                                  final placed = _placed[idx];
                                  return Container(
                                    width: 100,
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:
                                          placed != null
                                              ? Colors.teal.shade100
                                              : Colors.white,
                                      border: Border.all(
                                        color:
                                            placed != null
                                                ? Colors.teal
                                                : Colors.grey,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      placed ?? '...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontStyle:
                                            placed == null
                                                ? FontStyle.italic
                                                : FontStyle.normal,
                                        color:
                                            placed != null
                                                ? Colors.teal[900]
                                                : Colors.grey[600],
                                      ),
                                    ),
                                  );
                                },
                                onWillAccept: (opt) => true,
                                onAccept: (opt) => _onAccept(idx, opt),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Draggable options
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children:
                        _options.map((opt) {
                          final used = _placed.containsValue(opt);
                          return Opacity(
                            opacity: used ? 0.4 : 1.0,
                            child: Draggable<String>(
                              data: opt,
                              feedback: _buildChip(opt, isDragging: true),
                              child: _buildChip(opt),
                              childWhenDragging: _buildChip(opt, isGhost: true),
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 20,
              ),
            ),
            Positioned(
              top: 20,
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

  Widget _buildChip(
    String text, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            isGhost
                ? Colors.grey.shade300
                : isDragging
                ? Colors.teal.shade300
                : Colors.white,
        border: Border.all(color: Colors.teal, width: 1.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow:
            isDragging
                ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ]
                : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Flag icon if you supply one:
          Image.asset(
            'assets/flags/${text.toLowerCase()}.png',
            width: 24,
            height: 24,
            errorBuilder: (_, __, ___) => SizedBox(),
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isGhost ? Colors.grey : Colors.teal[900],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sentence {
  final String text;
  final String answer;
  _Sentence({required this.text, required this.answer});
}
