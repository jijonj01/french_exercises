import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class A1Seventeen extends StatefulWidget {
  @override
  _A1SeventeenState createState() => _A1SeventeenState();
}

class _A1SeventeenState extends State<A1Seventeen> {
  final List<String> questions = [
    'Vous vous appelez comment ?',
    'Quelle est votre nationalité ?',
    'Vous travaillez ?',
    'Vous avez des enfants ?',
  ];
  final Map<String, String> correctMatches = {
    'Vous vous appelez comment ?': 'Je m\'appelle Anna.',
    'Quelle est votre nationalité ?': 'Je suis espagnole.',
    'Vous travaillez ?': 'Oui, je suis journaliste au journal El Mundo.',
    'Vous avez des enfants ?': 'Oui, j\'ai deux filles.',
  };

  List<String> answers = [];
  Map<String, String> userMatches = {};
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    answers = correctMatches.values.toList()..shuffle();
  }

  void _checkAnswers() {
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
              child: Column(
                children: [
                  Text(
                    'Faites glisser la bonne réponse vers la question correspondante.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                            children:
                                questions.map((q) {
                                  final match = userMatches[q];
                                  final isCorrect =
                                      submitted && match == correctMatches[q];
                                  final isWrong =
                                      submitted &&
                                      match != null &&
                                      match != correctMatches[q];
                                  return Card(
                                    color:
                                        isCorrect
                                            ? Colors.green[100]
                                            : isWrong
                                            ? Colors.red[100]
                                            : Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: DragTarget<String>(
                                        onAccept: (value) {
                                          setState(() {
                                            userMatches[q] = value;
                                          });
                                        },
                                        builder: (
                                          context,
                                          candidateData,
                                          rejectedData,
                                        ) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                q,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: Text(
                                                  match ??
                                                      'Glissez-y la réponse',
                                                  style: TextStyle(
                                                    fontStyle:
                                                        match == null
                                                            ? FontStyle.italic
                                                            : FontStyle.normal,
                                                    color:
                                                        match == null
                                                            ? Colors.grey
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                        VerticalDivider(thickness: 1, width: 40),
                        Expanded(
                          child: ListView(
                            children:
                                answers.map((ans) {
                                  return Draggable<String>(
                                    data: ans,
                                    feedback: Material(
                                      child: Chip(
                                        label: Text(ans),
                                        elevation: 4,
                                      ),
                                    ),
                                    childWhenDragging: Opacity(
                                      opacity: 0.3,
                                      child: Chip(label: Text(ans)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Chip(label: Text(ans)),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _checkAnswers,
                    child: Text('Vérifier'),
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
