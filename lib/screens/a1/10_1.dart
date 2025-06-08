import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class A1Twenty extends StatefulWidget {
  const A1Twenty({Key? key}) : super(key: key);

  @override
  _A1TwentyState createState() => _A1TwentyState();
}

class _A1TwentyState extends State<A1Twenty> {
  final List<_MatchItem> _items = [
    _MatchItem(name: 'Nous sommes rouges et délicieuses.', emoji: '🍅'),
    _MatchItem(name: 'Je suis toute verte.', emoji: '🥬'),
    _MatchItem(
      name: 'Elle est noire et jaune, elle fait du miel.',
      emoji: '🐝',
    ),
    _MatchItem(
      name: 'Je suis ronde comme la terre, mais je suis orange et non bleue.',
      emoji: '🍊',
    ),
    _MatchItem(name: 'Je suis bleu, blanc, rouge.', emoji: '🇫🇷'),
    _MatchItem(name: 'Nous sommes roses et avons des épines.', emoji: '🌹'),
    _MatchItem(
      name: "S'il est marron, c'est qu'il est au chocolat.",
      emoji: '🍫',
    ),
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
      if (_items[targetIndex].name == data.name) {
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
                        return DragTarget<_MatchItem>(
                          onAccept: (data) => _onItemDropped(index, data),
                          builder: (context, candidateData, rejectedData) {
                            final matched = _targets[index] != null;
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      matched
                                          ? Colors.green
                                          : Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  matched
                                      ? _targets[index]!.emoji
                                      : _items[index].emoji,
                                  style: const TextStyle(fontSize: 60),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
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
                            child: _PhraseChip(text: item.name),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.4,
                            child: _PhraseChip(text: item.name),
                          ),
                          child: _PhraseChip(text: item.name),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (allMatched)
                    Text(
                      'Bravo ! Vous avez trouvé toutes les correspondances.',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                ],
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
}

class _MatchItem {
  final String name;
  final String emoji;
  _MatchItem({required this.name, required this.emoji});
}

class _PhraseChip extends StatelessWidget {
  final String text;
  const _PhraseChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
