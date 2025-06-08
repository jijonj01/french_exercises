import 'package:flutter/material.dart';

class A1Fifteen extends StatefulWidget {
  const A1Fifteen({Key? key}) : super(key: key);

  @override
  _A1FifteenState createState() => _A1FifteenState();
}

class _A1FifteenState extends State<A1Fifteen>
    with SingleTickerProviderStateMixin {
  final List<Question> _questions = [
    Question(
      prompt: 'Comment tu t\'appelles ? Je ___ Marie',
      options: ['m\'appelle', 't\'appelles', 's\'appelle'],
      answer: 'm\'appelle',
    ),
    Question(
      prompt: 'Tu ___ espagnol ?',
      options: ['es', 'suis', 'est'],
      answer: 'es',
    ),
    Question(
      prompt: 'Vous ___ des enfants ?',
      options: ['avez', 'avaient', 'ai'],
      answer: 'avez',
    ),
    Question(
      prompt: 'Je ___ étudiant à Paris',
      options: ['es', 'suis', 'est'],
      answer: 'suis',
    ),
    Question(
      prompt: 'Il/elle ___ professeur',
      options: ['est', 'sont', 'es'],
      answer: 'est',
    ),
    Question(
      prompt: 'J\'___ un chat',
      options: ['ai', 'as', 'a'],
      answer: 'ai',
    ),
  ];

  int _current = 0;
  int _score = 0;
  bool _answered = false;
  bool _finished = false;
  String? _selectedOption;

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void _select(String choice) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedOption = choice;
    });
    if (choice == _questions[_current].answer) _score++;

    Future.delayed(const Duration(seconds: 1), () {
      if (_current < _questions.length - 1) {
        _next();
      } else {
        _showResult();
      }
    });
  }

  void _next() {
    setState(() {
      _current++;
      _answered = false;
      _selectedOption = null;
      _controller.reset();
      _controller.forward();
    });
  }

  void _showResult() {
    setState(() {
      _finished = true;
    });
  }

  void _restart() {
    setState(() {
      _current = 0;
      _score = 0;
      _answered = false;
      _finished = false;
      _selectedOption = null;
      _controller.forward(from: 0);
    });
  }

  Widget _buildQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Question ${_current + 1} of ${_questions.length}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              _questions[_current].prompt,
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Spacer(),
        ..._questions[_current].options.map((opt) {
          final correct = opt == _questions[_current].answer;
          Color? bg;
          if (_answered && opt == _selectedOption) {
            bg = correct ? Colors.greenAccent : Colors.redAccent;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bg,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _select(opt),
              child: Text(opt, style: const TextStyle(fontSize: 18)),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bravo !\nVotre score: $_score / ${_questions.length}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _restart, child: const Text('Recommencer')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lexique Quiz'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74ABE2), Color(0xFF5563DE)],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3FDF5), Color(0xFFE6DCF5)],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child:
            _finished
                ? _buildResult()
                : FadeTransition(opacity: _fade, child: _buildQuiz()),
      ),
    );
  }
}

class Question {
  final String prompt;
  final List<String> options;
  final String answer;

  Question({required this.prompt, required this.options, required this.answer});
}
