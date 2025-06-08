import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class A1TwentyTwo extends StatefulWidget {
  const A1TwentyTwo({Key? key}) : super(key: key);

  @override
  _A1TwentyTwoState createState() => _A1TwentyTwoState();
}

class _A1TwentyTwoState extends State<A1TwentyTwo> {
  final List<_Round> rounds = [
    _Round(
      pattern: 'b',
      items: 'p b b d b d d p p q p b q d b d b b d q p b d d b q d'.split(' '),
    ),
    _Round(
      pattern: 'ou',
      items: 'ou on on oi ou on ou om on ou eu ou ou au ou oin ou'.split(' '),
    ),
    _Round(
      pattern: 'ai',
      items: 'ei ai ai ei al ai au ai an an ai ai oi ai ei ia ai ain ai ai'
          .split(' '),
    ),
    _Round(
      pattern: 'en',
      items: 'en an ein en ei en en ne em en en on me ne en ein en'.split(' '),
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (var r in rounds) {
      r.selection = List<bool>.filled(r.items.length, false);
      r.totalMatches = r.items.where((it) => it == r.pattern).toList().length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Column(
                children: [
                  for (var round in rounds) ...[
                    _buildRoundCard(round),
                    const SizedBox(height: 24),
                  ],
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

  Widget _buildRoundCard(_Round round) {
    int found =
        round.selection
            .asMap()
            .entries
            .where((e) => e.value && round.items[e.key] == round.pattern)
            .length;

    double progress = round.totalMatches > 0 ? found / round.totalMatches : 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with the model sign in a circle
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    round.pattern,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Entoure tous les "${round.pattern}"',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // The grid of tappable items
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(round.items.length, (i) {
                final text = round.items[i];
                final isSel = round.selection[i];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // only allow toggling correct ones
                      if (text == round.pattern) {
                        round.selection[i] = !round.selection[i];
                      } else {
                        // wrong tap feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Oups ! Essaie encore.'),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSel ? Colors.green.shade100 : Colors.white,
                      border: Border.all(
                        color: isSel ? Colors.green : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(text, style: const TextStyle(fontSize: 16)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            // Progress bar + check when done
            Row(
              children: [
                Expanded(child: LinearProgressIndicator(value: progress)),
                const SizedBox(width: 12),
                if (found == round.totalMatches)
                  const Icon(Icons.check_circle, color: Colors.green, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Round {
  final String pattern;
  final List<String> items;
  late List<bool> selection;
  late int totalMatches;

  _Round({required this.pattern, required this.items});
}
