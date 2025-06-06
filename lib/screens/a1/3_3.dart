import 'dart:async';

import 'package:flutter/material.dart';
import 'package:french_exercises/screens/header.dart';

/// Model for a word in the game
class WordItem {
  final String text;
  final String genre; // "masculin" or "féminin"
  final bool isPlural;

  WordItem({required this.text, required this.genre, required this.isPlural});
}

/// Main widget for the French Articles Game (Variante 2)
class A1Nine extends StatefulWidget {
  final String imageUrl;
  const A1Nine({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1NineState createState() => _A1NineState();
}

class _A1NineState extends State<A1Nine> {
  // ====== Section: Articles Indéfinis ======
  final List<WordItem> _initialWordsIndefini = [
    WordItem(text: 'arbre', genre: 'masculin', isPlural: false),
    WordItem(text: 'fenêtre', genre: 'féminin', isPlural: false),
    WordItem(text: 'livres', genre: 'masculin', isPlural: true),
    WordItem(text: 'maisons', genre: 'féminin', isPlural: true),
  ];
  late List<WordItem> _wordsIndefini; // remaining in pool
  final Map<String, List<WordItem>> _placedIndefini = {
    'Un': [],
    'Une': [],
    'Des': [],
  };
  String? _hoveredIndefiniBin;
  final Set<String> _wrongIndefiniBins = {};
  bool _showMessageIndefini = false;

  // ====== Section: Articles Définis ======
  final List<WordItem> _initialWordsDefini = [
    WordItem(text: 'arbre', genre: 'masculin', isPlural: false),
    WordItem(text: 'fenêtre', genre: 'féminin', isPlural: false),
    WordItem(text: 'livres', genre: 'masculin', isPlural: true),
    WordItem(text: 'maisons', genre: 'féminin', isPlural: true),
  ];
  late List<WordItem> _wordsDefini;
  final Map<String, List<WordItem>> _placedDefini = {
    'Le': [],
    'La': [],
    'Les': [],
  };
  String? _hoveredDefiniBin;
  final Set<String> _wrongDefiniBins = {};
  bool _showMessageDefini = false;

  @override
  void initState() {
    super.initState();
    _resetIndefini();
    _resetDefini();
  }

  void _resetIndefini() {
    _wordsIndefini = List.from(_initialWordsIndefini);
    _placedIndefini.forEach((key, list) => list.clear());
    _hoveredIndefiniBin = null;
    _wrongIndefiniBins.clear();
    _showMessageIndefini = false;
  }

  void _resetDefini() {
    _wordsDefini = List.from(_initialWordsDefini);
    _placedDefini.forEach((key, list) => list.clear());
    _hoveredDefiniBin = null;
    _wrongDefiniBins.clear();
    _showMessageDefini = false;
  }

  /// Check if a word matches the indefinite article rules
  bool _matchesIndefini(String article, WordItem word) {
    if (article == 'Un' && word.genre == 'masculin' && !word.isPlural) {
      return true;
    }
    if (article == 'Une' && word.genre == 'féminin' && !word.isPlural) {
      return true;
    }
    if (article == 'Des' && word.isPlural) {
      return true;
    }
    return false;
  }

  /// Check if a word matches the definite article rules
  bool _matchesDefini(String article, WordItem word) {
    if (article == 'Le' && word.genre == 'masculin' && !word.isPlural) {
      return true;
    }
    if (article == 'La' && word.genre == 'féminin' && !word.isPlural) {
      return true;
    }
    if (article == 'Les' && word.isPlural) {
      return true;
    }
    return false;
  }

  /// Builds a styled word card; if [draggable] is true, wraps in Draggable.
  Widget _buildWordCard(
    WordItem word, {
    required bool draggable,
    required VoidCallback? onDragStarted,
  }) {
    final card = Container(
      width: 100,
      height: 40,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF777777)),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        word.text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );

    if (!draggable) return card;

    return Draggable<WordItem>(
      data: word,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.75, child: card),
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: card),
      onDragStarted: onDragStarted,
      child: card,
    );
  }

  /// Builds a single Bin (DragTarget) widget.
  Widget _buildBin({required String label, required bool isIndefiniSection}) {
    // Choose state sets based on section
    final hoveredBin =
        isIndefiniSection ? _hoveredIndefiniBin : _hoveredDefiniBin;
    final wrongBins = isIndefiniSection ? _wrongIndefiniBins : _wrongDefiniBins;
    final placedMap = isIndefiniSection ? _placedIndefini : _placedDefini;
    final matchFn = isIndefiniSection ? _matchesIndefini : _matchesDefini;
    final remainingWords = isIndefiniSection ? _wordsIndefini : _wordsDefini;
    final placedLists = placedMap[label]!;

    final isHovered = hoveredBin == label;
    final isCorrect = placedLists.isNotEmpty;
    final isWrong = wrongBins.contains(label);

    Color backgroundColor = const Color(0xFFFAFAFA);
    Color borderColor = const Color(0xFFAAAAAA);

    if (isCorrect) {
      backgroundColor = const Color(0xFFC8E6C9);
      borderColor = const Color(0xFF388E3C);
    } else if (isWrong) {
      backgroundColor = const Color(0xFFFAFAFA);
      borderColor = const Color(0xFFE53935);
    } else if (isHovered) {
      backgroundColor = const Color(0xFFE0F7FA);
      borderColor = const Color(0xFF00ACC1);
    }

    return DragTarget<WordItem>(
      onWillAccept: (word) {
        setState(() {
          if (isIndefiniSection) {
            _hoveredIndefiniBin = label;
          } else {
            _hoveredDefiniBin = label;
          }
        });
        return true;
      },
      onLeave: (word) {
        setState(() {
          if (isIndefiniSection) {
            _hoveredIndefiniBin = null;
          } else {
            _hoveredDefiniBin = null;
          }
        });
      },
      onAccept: (word) {
        final correct = matchFn(label, word);
        if (correct) {
          setState(() {
            placedLists.add(word);
            remainingWords.remove(word);

            // Check if all words have been placed in this section
            if (isIndefiniSection) {
              final totalPlaced = _placedIndefini.values.fold<int>(
                0,
                (sum, list) => sum + list.length,
              );
              if (totalPlaced == _initialWordsIndefini.length) {
                _showMessageIndefini = true;
              }
            } else {
              final totalPlaced = _placedDefini.values.fold<int>(
                0,
                (sum, list) => sum + list.length,
              );
              if (totalPlaced == _initialWordsDefini.length) {
                _showMessageDefini = true;
              }
            }
          });
        } else {
          setState(() {
            if (isIndefiniSection) {
              _wrongIndefiniBins.add(label);
            } else {
              _wrongDefiniBins.add(label);
            }
          });
          Timer(const Duration(milliseconds: 300), () {
            setState(() {
              if (isIndefiniSection) {
                _wrongIndefiniBins.remove(label);
              } else {
                _wrongDefiniBins.remove(label);
              }
            });
          });
        }
        // Clear hover state after drop
        setState(() {
          if (isIndefiniSection) {
            _hoveredIndefiniBin = null;
          } else {
            _hoveredDefiniBin = null;
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 120,
          constraints: const BoxConstraints(minHeight: 80),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (placedLists.isNotEmpty) ...[
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children:
                      placedLists
                          .map(
                            (word) => _buildWordCard(
                              word,
                              draggable: false,
                              onDragStarted: null,
                            ),
                          )
                          .toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Builds the full section for either Indéfinis or Définis
  Widget _buildSection({
    required String title,
    required String instructions,
    required List<String> bins,
    required List<WordItem> wordsPool,
    required Map<String, List<WordItem>> placedMap,
    required bool isIndefini,
    required bool showMessage,
    required String messageText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF444444),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            instructions,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Bins
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children:
                bins
                    .map(
                      (label) => _buildBin(
                        label: label,
                        isIndefiniSection: isIndefini,
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 30),
          // Word Pool
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children:
                wordsPool.map((word) {
                  return _buildWordCard(
                    word,
                    draggable: true,
                    onDragStarted: () {
                      // clear any hover highlight before dragging
                      setState(() {
                        if (isIndefini) {
                          _hoveredIndefiniBin = null;
                        } else {
                          _hoveredDefiniBin = null;
                        }
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 20),
          if (showMessage)
            Text(
              messageText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF388E3C),
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            GameHeader(imageUrl: widget.imageUrl, heroTag: widget.imageUrl),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 220),
                  // Section 1: Articles Indéfinis
                  _buildSection(
                    title: 'Articles indéfinis (Un, Une, Des)',
                    instructions:
                        'Glissez chaque mot vers l’article indéfini approprié.\n\n'
                        'Un → nom masculin singulier\n'
                        'Une → nom féminin singulier\n'
                        'Des → nom pluriel',
                    bins: const ['Un', 'Une', 'Des'],
                    wordsPool: _wordsIndefini,
                    placedMap: _placedIndefini,
                    isIndefini: true,
                    showMessage: _showMessageIndefini,
                    messageText:
                        'Bravo ! Tous les mots indéfinis sont correctement classés !',
                  ),

                  // Section 2: Articles Définis
                  _buildSection(
                    title: 'Articles définis (Le, La, Les)',
                    instructions:
                        'Glissez chaque mot vers l’article défini approprié.\n\n'
                        'Le → nom masculin singulier\n'
                        'La → nom féminin singulier\n'
                        'Les → nom pluriel',
                    bins: const ['Le', 'La', 'Les'],
                    wordsPool: _wordsDefini,
                    placedMap: _placedDefini,
                    isIndefini: false,
                    showMessage: _showMessageDefini,
                    messageText:
                        'Félicitations ! Tous les mots définis sont correctement classés !',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
