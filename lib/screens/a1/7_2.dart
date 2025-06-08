import 'package:flutter/material.dart';

class A1Sixteen extends StatefulWidget {
  const A1Sixteen({Key? key}) : super(key: key);

  @override
  _A1SixteenState createState() => _A1SixteenState();
}

class _A1SixteenState extends State<A1Sixteen> {
  final List<Sentence> _sentences = [
    Sentence(parts: ['Bonjour, ', ' t\'appelles comment?'], answer: 'tu'),
    Sentence(parts: ['Il ', ' professeur.'], answer: 'est'),
    Sentence(parts: ['Nous ', ' amis.'], answer: 'sommes'),
    Sentence(parts: ['J\'', ' faim.'], answer: 'ai'),
    Sentence(parts: ['Vous ', ' déjà allé?'], answer: 'êtes'),
    Sentence(parts: ['Elle ', ' heureuse.'], answer: 'est'),
  ];

  late List<String> _choices;
  bool _finished = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _initChoices();
  }

  void _initChoices() {
    _choices =
        _sentences.map((s) => s.answer).toList()
          ..addAll(['suis', 'as', 'avons'])
          ..shuffle();
  }

  void _checkResult() {
    int correct = 0;
    for (var s in _sentences) {
      if (s.placed == s.answer) correct++;
    }
    setState(() {
      _score = correct;
      _finished = true;
    });
  }

  void _restart() {
    for (var s in _sentences) {
      s.placed = null;
    }
    _initChoices();
    setState(() {
      _finished = false;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag & Drop Verbes'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFFAD961), Color(0xFFF76B1C)],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _sentences.length,
                itemBuilder: (context, i) {
                  final sentence = _sentences[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          sentence.parts[0],
                          style: const TextStyle(fontSize: 18),
                        ),
                        DragTarget<String>(
                          builder: (context, candidate, rejected) {
                            return Container(
                              width: 80,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    sentence.placed == null
                                        ? Colors.white
                                        : (sentence.placed == sentence.answer
                                            ? Colors.lightGreenAccent
                                            : Colors.redAccent),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black45),
                              ),
                              child: Text(
                                sentence.placed ?? '______',
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          },
                          onAccept: (data) {
                            setState(() {
                              sentence.placed = data;
                            });
                          },
                        ),
                        Text(
                          sentence.parts[1],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _choices.map((c) {
                    return Draggable<String>(
                      data: c,
                      feedback: Material(
                        child: Chip(
                          label: Text(c, style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: Chip(label: Text(c)),
                      ),
                      child: Chip(label: Text(c)),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),
            if (!_finished)
              ElevatedButton(
                onPressed: _checkResult,
                child: const Text('Vérifier'),
              )
            else
              Column(
                children: [
                  Text(
                    'Score: $_score / ${_sentences.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _restart,
                    child: const Text('Recommencer'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Sentence {
  final List<String> parts;
  final String answer;
  String? placed;

  Sentence({required this.parts, required this.answer});
}
