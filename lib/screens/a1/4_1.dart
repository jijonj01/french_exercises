import 'dart:math';
import 'package:flutter/material.dart';

class A1Ten extends StatefulWidget {
  const A1Ten({Key? key}) : super(key: key);

  @override
  _A1TenState createState() => _A1TenState();
}

class _A1TenState extends State<A1Ten> {
  // Données de chaque verbe : liste de couples { pronom, conjugaison }
  static const Map<String, List<Map<String, String>>> _jeux = {
    // ————— Verbes en -er —————
    "Parler": [
      {"pronom": "Je", "conjug": "parle"},
      {"pronom": "Tu", "conjug": "parles"},
      {"pronom": "Il/elle", "conjug": "parle"},
      {"pronom": "Nous", "conjug": "parlons"},
      {"pronom": "Vous", "conjug": "parlez"},
      {"pronom": "Ils/elles", "conjug": "parlent"},
    ],
    "Habiter": [
      {"pronom": "Je", "conjug": "habite"},
      {"pronom": "Tu", "conjug": "habites"},
      {"pronom": "Il/elle", "conjug": "habite"},
      {"pronom": "Nous", "conjug": "habitons"},
      {"pronom": "Vous", "conjug": "habitez"},
      {"pronom": "Ils/elles", "conjug": "habitent"},
    ],
    "Aimer": [
      {"pronom": "Je", "conjug": "aime"},
      {"pronom": "Tu", "conjug": "aimes"},
      {"pronom": "Il/elle", "conjug": "aime"},
      {"pronom": "Nous", "conjug": "aimons"},
      {"pronom": "Vous", "conjug": "aimez"},
      {"pronom": "Ils/elles", "conjug": "aiment"},
    ],
    "Manger": [
      {"pronom": "Je", "conjug": "mange"},
      {"pronom": "Tu", "conjug": "manges"},
      {"pronom": "Il/elle", "conjug": "mange"},
      {"pronom": "Nous", "conjug": "mangeons"},
      {"pronom": "Vous", "conjug": "mangez"},
      {"pronom": "Ils/elles", "conjug": "mangent"},
    ],
    "Jouer": [
      {"pronom": "Je", "conjug": "joue"},
      {"pronom": "Tu", "conjug": "joues"},
      {"pronom": "Il/elle", "conjug": "joue"},
      {"pronom": "Nous", "conjug": "jouons"},
      {"pronom": "Vous", "conjug": "jouez"},
      {"pronom": "Ils/elles", "conjug": "jouent"},
    ],
    "Regarder": [
      {"pronom": "Je", "conjug": "regarde"},
      {"pronom": "Tu", "conjug": "regardes"},
      {"pronom": "Il/elle", "conjug": "regarde"},
      {"pronom": "Nous", "conjug": "regardons"},
      {"pronom": "Vous", "conjug": "regardez"},
      {"pronom": "Ils/elles", "conjug": "regardent"},
    ],
    "Travailler": [
      {"pronom": "Je", "conjug": "travaille"},
      {"pronom": "Tu", "conjug": "travailles"},
      {"pronom": "Il/elle", "conjug": "travaille"},
      {"pronom": "Nous", "conjug": "travaillons"},
      {"pronom": "Vous", "conjug": "travaillez"},
      {"pronom": "Ils/elles", "conjug": "travaillent"},
    ],
    "Étudier": [
      {"pronom": "Je", "conjug": "étudie"},
      {"pronom": "Tu", "conjug": "étudies"},
      {"pronom": "Il/elle", "conjug": "étudie"},
      {"pronom": "Nous", "conjug": "étudions"},
      {"pronom": "Vous", "conjug": "étudiez"},
      {"pronom": "Ils/elles", "conjug": "étudient"},
    ],
    "Chanter": [
      {"pronom": "Je", "conjug": "chante"},
      {"pronom": "Tu", "conjug": "chantes"},
      {"pronom": "Il/elle", "conjug": "chante"},
      {"pronom": "Nous", "conjug": "chantons"},
      {"pronom": "Vous", "conjug": "chantez"},
      {"pronom": "Ils/elles", "conjug": "chantent"},
    ],
    "Danser": [
      {"pronom": "Je", "conjug": "danse"},
      {"pronom": "Tu", "conjug": "danses"},
      {"pronom": "Il/elle", "conjug": "danse"},
      {"pronom": "Nous", "conjug": "dansons"},
      {"pronom": "Vous", "conjug": "dansez"},
      {"pronom": "Ils/elles", "conjug": "dansent"},
    ],
    "Écouter": [
      {"pronom": "Je", "conjug": "écoute"},
      {"pronom": "Tu", "conjug": "écoutes"},
      {"pronom": "Il/elle", "conjug": "écoute"},
      {"pronom": "Nous", "conjug": "écoutons"},
      {"pronom": "Vous", "conjug": "écoutez"},
      {"pronom": "Ils/elles", "conjug": "écoutent"},
    ],

    // ————— Verbes en -ir —————
    "Finir": [
      {"pronom": "Je", "conjug": "finis"},
      {"pronom": "Tu", "conjug": "finis"},
      {"pronom": "Il/elle", "conjug": "finit"},
      {"pronom": "Nous", "conjug": "finissons"},
      {"pronom": "Vous", "conjug": "finissez"},
      {"pronom": "Ils/elles", "conjug": "finissent"},
    ],
    "Choisir": [
      {"pronom": "Je", "conjug": "choisis"},
      {"pronom": "Tu", "conjug": "choisis"},
      {"pronom": "Il/elle", "conjug": "choisit"},
      {"pronom": "Nous", "conjug": "choisissons"},
      {"pronom": "Vous", "conjug": "choisissez"},
      {"pronom": "Ils/elles", "conjug": "choisissent"},
    ],
    "Réussir": [
      {"pronom": "Je", "conjug": "réussis"},
      {"pronom": "Tu", "conjug": "réussis"},
      {"pronom": "Il/elle", "conjug": "réussit"},
      {"pronom": "Nous", "conjug": "réussissons"},
      {"pronom": "Vous", "conjug": "réussissez"},
      {"pronom": "Ils/elles", "conjug": "réussissent"},
    ],
    "Rougir": [
      {"pronom": "Je", "conjug": "rougis"},
      {"pronom": "Tu", "conjug": "rougis"},
      {"pronom": "Il/elle", "conjug": "rougit"},
      {"pronom": "Nous", "conjug": "rougissons"},
      {"pronom": "Vous", "conjug": "rougissez"},
      {"pronom": "Ils/elles", "conjug": "rougissent"},
    ],
    "Grandir": [
      {"pronom": "Je", "conjug": "grandis"},
      {"pronom": "Tu", "conjug": "grandis"},
      {"pronom": "Il/elle", "conjug": "grandit"},
      {"pronom": "Nous", "conjug": "grandissons"},
      {"pronom": "Vous", "conjug": "grandissez"},
      {"pronom": "Ils/elles", "conjug": "grandissent"},
    ],
    "Applaudir": [
      {"pronom": "Je", "conjug": "applaudis"},
      {"pronom": "Tu", "conjug": "applaudis"},
      {"pronom": "Il/elle", "conjug": "applaudit"},
      {"pronom": "Nous", "conjug": "applaudissons"},
      {"pronom": "Vous", "conjug": "applaudissez"},
      {"pronom": "Ils/elles", "conjug": "applaudissent"},
    ],
    "Guérir": [
      {"pronom": "Je", "conjug": "guéris"},
      {"pronom": "Tu", "conjug": "guéris"},
      {"pronom": "Il/elle", "conjug": "guérit"},
      {"pronom": "Nous", "conjug": "guérissons"},
      {"pronom": "Vous", "conjug": "guérissez"},
      {"pronom": "Ils/elles", "conjug": "guérissent"},
    ],

    // ————— Verbes en -re —————
    "Vendre": [
      {"pronom": "Je", "conjug": "vends"},
      {"pronom": "Tu", "conjug": "vends"},
      {"pronom": "Il/elle", "conjug": "vend"},
      {"pronom": "Nous", "conjug": "vendons"},
      {"pronom": "Vous", "conjug": "vendez"},
      {"pronom": "Ils/elles", "conjug": "vendent"},
    ],
    "Attendre": [
      {"pronom": "Je", "conjug": "attends"},
      {"pronom": "Tu", "conjug": "attends"},
      {"pronom": "Il/elle", "conjug": "attend"},
      {"pronom": "Nous", "conjug": "attendons"},
      {"pronom": "Vous", "conjug": "attendez"},
      {"pronom": "Ils/elles", "conjug": "attendent"},
    ],
    "Entendre": [
      {"pronom": "Je", "conjug": "entends"},
      {"pronom": "Tu", "conjug": "entends"},
      {"pronom": "Il/elle", "conjug": "entend"},
      {"pronom": "Nous", "conjug": "entendons"},
      {"pronom": "Vous", "conjug": "entendez"},
      {"pronom": "Ils/elles", "conjug": "entendent"},
    ],
    "Répondre": [
      {"pronom": "Je", "conjug": "réponds"},
      {"pronom": "Tu", "conjug": "réponds"},
      {"pronom": "Il/elle", "conjug": "répond"},
      {"pronom": "Nous", "conjug": "répondons"},
      {"pronom": "Vous", "conjug": "répondez"},
      {"pronom": "Ils/elles", "conjug": "répondent"},
    ],
    "Perdre": [
      {"pronom": "Je", "conjug": "perds"},
      {"pronom": "Tu", "conjug": "perds"},
      {"pronom": "Il/elle", "conjug": "perd"},
      {"pronom": "Nous", "conjug": "perdons"},
      {"pronom": "Vous", "conjug": "perdez"},
      {"pronom": "Ils/elles", "conjug": "perdent"},
    ],
    "Descendre": [
      {"pronom": "Je", "conjug": "descends"},
      {"pronom": "Tu", "conjug": "descends"},
      {"pronom": "Il/elle", "conjug": "descend"},
      {"pronom": "Nous", "conjug": "descendons"},
      {"pronom": "Vous", "conjug": "descendez"},
      {"pronom": "Ils/elles", "conjug": "descendent"},
    ],

    // ————— Verbes irréguliers fréquents —————
    "Être": [
      {"pronom": "Je", "conjug": "suis"},
      {"pronom": "Tu", "conjug": "es"},
      {"pronom": "Il/elle", "conjug": "est"},
      {"pronom": "On", "conjug": "est"},
      {"pronom": "Nous", "conjug": "sommes"},
      {"pronom": "Vous", "conjug": "êtes"},
      {"pronom": "Ils/elles", "conjug": "sont"},
    ],
    "Avoir": [
      {"pronom": "Je", "conjug": "ai"},
      {"pronom": "Tu", "conjug": "as"},
      {"pronom": "Il/elle", "conjug": "a"},
      {"pronom": "On", "conjug": "a"},
      {"pronom": "Nous", "conjug": "avons"},
      {"pronom": "Vous", "conjug": "avez"},
      {"pronom": "Ils/elles", "conjug": "ont"},
    ],
    "Aller": [
      {"pronom": "Je", "conjug": "vais"},
      {"pronom": "Tu", "conjug": "vas"},
      {"pronom": "Il/elle", "conjug": "va"},
      {"pronom": "On", "conjug": "va"},
      {"pronom": "Nous", "conjug": "allons"},
      {"pronom": "Vous", "conjug": "allez"},
      {"pronom": "Ils/elles", "conjug": "vont"},
    ],
    "Faire": [
      {"pronom": "Je", "conjug": "fais"},
      {"pronom": "Tu", "conjug": "fais"},
      {"pronom": "Il/elle", "conjug": "fait"},
      {"pronom": "On", "conjug": "fait"},
      {"pronom": "Nous", "conjug": "faisons"},
      {"pronom": "Vous", "conjug": "faites"},
      {"pronom": "Ils/elles", "conjug": "font"},
    ],
    "Venir": [
      {"pronom": "Je", "conjug": "viens"},
      {"pronom": "Tu", "conjug": "viens"},
      {"pronom": "Il/elle", "conjug": "vient"},
      {"pronom": "On", "conjug": "vient"},
      {"pronom": "Nous", "conjug": "venons"},
      {"pronom": "Vous", "conjug": "venez"},
      {"pronom": "Ils/elles", "conjug": "viennent"},
    ],
    "Pouvoir": [
      {"pronom": "Je", "conjug": "peux"},
      {"pronom": "Tu", "conjug": "peux"},
      {"pronom": "Il/elle", "conjug": "peut"},
      {"pronom": "On", "conjug": "peut"},
      {"pronom": "Nous", "conjug": "pouvons"},
      {"pronom": "Vous", "conjug": "pouvez"},
      {"pronom": "Ils/elles", "conjug": "peuvent"},
    ],
    "Vouloir": [
      {"pronom": "Je", "conjug": "veux"},
      {"pronom": "Tu", "conjug": "veux"},
      {"pronom": "Il/elle", "conjug": "veut"},
      {"pronom": "On", "conjug": "veut"},
      {"pronom": "Nous", "conjug": "voulons"},
      {"pronom": "Vous", "conjug": "voulez"},
      {"pronom": "Ils/elles", "conjug": "veulent"},
    ],
    "Devoir": [
      {"pronom": "Je", "conjug": "dois"},
      {"pronom": "Tu", "conjug": "dois"},
      {"pronom": "Il/elle", "conjug": "doit"},
      {"pronom": "On", "conjug": "doit"},
      {"pronom": "Nous", "conjug": "devons"},
      {"pronom": "Vous", "conjug": "devez"},
      {"pronom": "Ils/elles", "conjug": "doivent"},
    ],
    "Sappeler": [
      {"pronom": "Je", "conjug": "m’appelle"},
      {"pronom": "Tu", "conjug": "t’appelles"},
      {"pronom": "Il/elle", "conjug": "s’appelle"},
      {"pronom": "Nous", "conjug": "nous appelons"},
      {"pronom": "Vous", "conjug": "vous appelez"},
      {"pronom": "Ils/elles", "conjug": "s’appellent"},
    ],
  };

  List<_CardInfo> _cards = [];
  List<int> _flippedIndices = [];
  int _foundPairs = 0;
  late int _totalPairs;
  String _selectedVerb = _jeux.keys.first;
  String _message = "";

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final pairs = _jeux[_selectedVerb]!;
    _totalPairs = pairs.length;
    _foundPairs = 0;
    _message = "";
    _flippedIndices.clear();

    // Build a list of two cards per pair: one "pronom" and one "conjug"
    final temp = <_CardInfo>[];
    for (var i = 0; i < pairs.length; i++) {
      final pronom = pairs[i]["pronom"]!;
      final conjug = pairs[i]["conjug"]!;
      temp.add(_CardInfo(id: i, type: _CardType.pronom, text: pronom));
      temp.add(_CardInfo(id: i, type: _CardType.conjug, text: conjug));
    }

    // Shuffle
    temp.shuffle();
    setState(() {
      _cards = temp;
    });
  }

  void _onCardTap(int index) {
    if (_cards[index].matched || _flippedIndices.length == 2) return;
    if (_flippedIndices.contains(index)) return;

    setState(() {
      _flippedIndices.add(index);
    });

    if (_flippedIndices.length == 2) {
      final first = _cards[_flippedIndices[0]];
      final second = _cards[_flippedIndices[1]];

      if (first.id == second.id && first.type != second.type) {
        // Correct match
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            first.matched = true;
            second.matched = true;
            _flippedIndices.clear();
            _foundPairs++;
            if (_foundPairs == _totalPairs) {
              _message = "Félicitations ! Tu as apparié toutes les paires !";
            }
          });
        });
      } else {
        // Not a match
        Future.delayed(const Duration(milliseconds: 800), () {
          setState(() {
            _flippedIndices.clear();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardCount = _cards.length;
    final crossAxisCount = (sqrt(cardCount)).ceil();

    return Scaffold(
      backgroundColor: const Color(0xFFf0f4f7),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          "Pronoms et Conjugaisons",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Controls: dropdown + reset button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choisis un verbe : ",
                  style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedVerb,
                  items:
                      _jeux.keys
                          .map(
                            (verb) => DropdownMenuItem(
                              value: verb,
                              child: Text(verb),
                            ),
                          )
                          .toList(),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _selectedVerb = v;
                    });
                    _initializeGame();
                  },
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onPressed: _initializeGame,
                  child: Icon(Icons.refresh, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Instructions
            const Text(
              "Clique sur une carte pour la retourner, puis clique sur une deuxième pour former la paire correcte entre pronom et conjugaison. Si c'est correct, elles disparaissent ; sinon, elles se retournent.",
              style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Grid of cards
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cardCount,
                itemBuilder: (context, idx) {
                  final card = _cards[idx];
                  final isFlipped = _flippedIndices.contains(idx);
                  return FlipCard(
                    text: card.text,
                    isFlipped: isFlipped || card.matched,
                    hidden: card.matched,
                    onTap: () {
                      _onCardTap(idx);
                    },
                  );
                },
              ),
            ),

            // Message on completion
            const SizedBox(height: 8),
            Text(
              _message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2e86de),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// Types for cards
enum _CardType { pronom, conjug }

/// Internal model for a card
class _CardInfo {
  final int id;
  final _CardType type;
  final String text;
  bool matched;

  _CardInfo({
    required this.id,
    required this.type,
    required this.text,
    this.matched = false,
  });
}

/// A widget that flips between a “?” front face and a text back face.
class FlipCard extends StatefulWidget {
  final String text;
  final bool isFlipped;
  final bool hidden;
  final VoidCallback onTap;

  const FlipCard({
    Key? key,
    required this.text,
    required this.isFlipped,
    required this.hidden,
    required this.onTap,
  }) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant FlipCard old) {
    super.didUpdateWidget(old);
    // Trigger flip animation when isFlipped changes
    if (widget.isFlipped && !old.isFlipped) {
      _controller.forward();
    } else if (!widget.isFlipped && old.isFlipped) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden) {
      // If matched, render as invisible
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: widget.isFlipped ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value;
          final isUnderHalf = angle <= pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
            child: Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                color:
                    isUnderHalf
                        ? Colors.lightGreen
                        : Colors.white, // front vs back
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child:
                  isUnderHalf
                      ? const Text(
                        "?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
