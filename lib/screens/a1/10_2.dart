import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class A1TwentyOne extends StatefulWidget {
  const A1TwentyOne({Key? key}) : super(key: key);

  @override
  _A1TwentyOneState createState() => _A1TwentyOneState();
}

class _A1TwentyOneState extends State<A1TwentyOne> {
  final List<_MatchItem> _items = [
    _MatchItem(question: 'Combien font 2 + 2 ?', answer: '4'),
    _MatchItem(question: 'Capitale de l\'Espagne ?', answer: 'Madrid'),
    _MatchItem(question: 'De quelle couleur est le ciel ?', answer: 'Bleu'),
    _MatchItem(question: 'Opposé de chaud ?', answer: 'Froid'),
    _MatchItem(question: 'Symbole chimique de l\'eau ?', answer: 'H₂O'),
    _MatchItem(question: 'Quel jour vient après lundi ?', answer: 'Mardi'),
  ];

  late List<_MatchItem> _draggables;
  late List<_MatchItem?> _targets;

  @override
  void initState() {
    super.initState();
    _draggables = List.from(_items)..shuffle();
    _targets = List<_MatchItem?>.filled(_items.length, null);
  }

  void _onItemDropped(int targetIndex, _MatchItem data) {
    setState(() {
      if (_items[targetIndex].answer == data.answer) {
        _targets[targetIndex] = data;
        _draggables.remove(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allMatched = _targets.every((t) => t != null);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final matched = _targets[index] != null;
                        return DragTarget<_MatchItem>(
                          onAccept: (data) => _onItemDropped(index, data),
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: matched ? Colors.green : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  matched
                                      ? _targets[index]!.answer
                                      : _items[index].question,
                                  style: TextStyle(
                                    fontSize: matched ? 20 : 16,
                                    fontWeight:
                                        matched
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        matched
                                            ? Colors.green.shade800
                                            : Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const Divider(height: 32),

                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _draggables.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final item = _draggables[index];
                        return Draggable<_MatchItem>(
                          data: item,
                          feedback: Material(
                            color: Colors.transparent,
                            child: _PhraseChip(text: item.answer),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.4,
                            child: _PhraseChip(text: item.answer),
                          ),
                          child: _PhraseChip(text: item.answer),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  if (allMatched)
                    Text(
                      '🎉 Bravo ! Vous avez apparié toutes les questions et réponses !',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),

            Positioned(
              top: 20,
              left: 16,
              child: GestureDetector(
                onTap: () => context.pop(),
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

class _MatchItem {
  final String question;
  final String answer;
  _MatchItem({required this.question, required this.answer});
}

class _PhraseChip extends StatelessWidget {
  final String text;
  const _PhraseChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
