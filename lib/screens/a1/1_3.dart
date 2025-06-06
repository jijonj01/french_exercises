import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class A1Three extends StatefulWidget {
  final String imageUrl;
  const A1Three({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<A1Three> createState() => _A1ThreeState();
}

class _A1ThreeState extends State<A1Three> {
  // ====== Exercise 1 state ======
  final Map<String, String?> _exercise1Answers = {
    'c1': null, // D
    'c2': null, // A
    'c3': null, // S
    'c4': null, // O
    'c5': null, // E
    'c6': null, // T
  };

  // ====== Exercise 2 state ======
  final Map<String, String?> _exercise2Answers = {
    'a': null, // L’accent aigu
    'b': null, // L’accent grave
    'c': null, // La cédille
    'd': null, // L’accent circonflexe
    'e': null, // Le tréma
  };

  // ====== Exercise 3 state ======
  final Map<String, TextEditingController> _exercise3Controllers = {
    'w1': TextEditingController(), // M_re → È (MÈRE)
    'w2': TextEditingController(), // _le → Î (ÎLE)
    'w3': TextEditingController(), // Gar_on → Ç (GARÇON)
    'w4': TextEditingController(), // H_pital → Ô (HÔPITAL)
    'w5': TextEditingController(), // Ambigu_ → Ü (AMBIGÜE)
  };

  // To display results after checking
  bool _showResults = false;
  int _score1 = 0;
  int _score2 = 0;
  int _score3 = 0;

  // Correct answers for Exercise 1
  final Map<String, String> _correct1 = {
    'c1': 'consonne', // D
    'c2': 'voyelle', // A
    'c3': 'consonne', // S
    'c4': 'voyelle', // O
    'c5': 'voyelle', // E
    'c6': 'consonne', // T
  };

  // Correct answers for Exercise 2
  final Map<String, String> _correct2 = {
    'a': 'é', // Accent aigu
    'b': 'à', // Accent grave
    'c': 'ç', // Cédille
    'd': 'â', // Circonflexe
    'e': 'ë', // Tréma
  };

  // Correct answers for Exercise 3
  final Map<String, String> _correct3 = {
    'w1': 'È', // MÈRE
    'w2': 'Î', // ÎLE
    'w3': 'Ç', // GARÇON
    'w4': 'Ô', // HÔPITAL
    'w5': 'Ü', // AMBIGÜE
  };

  // Mapping of common accented characters to their base letter
  static const Map<String, String> _diacriticsMap = {
    'À': 'A',
    'Â': 'A',
    'Ä': 'A',
    'Á': 'A',
    'Ã': 'A',
    'Å': 'A',
    'Æ': 'AE',
    'Ç': 'C',
    'È': 'E',
    'É': 'E',
    'Ê': 'E',
    'Ë': 'E',
    'Ì': 'I',
    'Í': 'I',
    'Î': 'I',
    'Ï': 'I',
    'Ð': 'D',
    'Ñ': 'N',
    'Ò': 'O',
    'Ó': 'O',
    'Ô': 'O',
    'Ö': 'O',
    'Õ': 'O',
    'Ø': 'O',
    'Œ': 'OE',
    'Ù': 'U',
    'Ú': 'U',
    'Û': 'U',
    'Ü': 'U',
    'Ý': 'Y',
    'Ÿ': 'Y',
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ä': 'a',
    'ã': 'a',
    'å': 'a',
    'æ': 'ae',
    'ç': 'c',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ì': 'i',
    'í': 'i',
    'î': 'i',
    'ï': 'i',
    'ð': 'd',
    'ñ': 'n',
    'ò': 'o',
    'ó': 'o',
    'ô': 'o',
    'ö': 'o',
    'õ': 'o',
    'ø': 'o',
    'œ': 'oe',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'ý': 'y',
    'ÿ': 'y',
  };

  /// Remove diacritics by mapping each character to its base form.
  String _removeDiacritics(String input) {
    final buffer = StringBuffer();
    for (final char in input.characters) {
      if (_diacriticsMap.containsKey(char)) {
        buffer.write(_diacriticsMap[char]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  void _checkAnswers() {
    // Exercise 1 scoring
    int score1 = 0;
    _correct1.forEach((key, correctValue) {
      final userChoice = _exercise1Answers[key];
      if (userChoice != null && userChoice == correctValue) {
        score1++;
      }
    });

    // Exercise 2 scoring
    int score2 = 0;
    _correct2.forEach((key, correctValue) {
      final userChoice = _exercise2Answers[key];
      if (userChoice != null && userChoice == correctValue) {
        score2++;
      }
    });

    // Exercise 3 scoring
    int score3 = 0;
    _correct3.forEach((key, correctValue) {
      final userInput = _exercise3Controllers[key]!.text.trim();
      if (userInput.isEmpty) return;
      final normalizedInput = _removeDiacritics(userInput).toUpperCase();
      final normalizedCorrect = _removeDiacritics(correctValue).toUpperCase();
      if (normalizedInput == normalizedCorrect) {
        score3++;
      }
    });

    setState(() {
      _score1 = score1;
      _score2 = score2;
      _score3 = score3;
      _showResults = true;
    });
  }

  @override
  void dispose() {
    for (final controller in _exercise3Controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar: use a custom header with image and back button
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // --- HEADER IMAGE + BACK/BKMK OVERLAYS ---
                Stack(
                  children: [
                    ClipRRect(
                      child: Hero(
                        tag: widget.imageUrl,
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Back arrow (top left)
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
                    // Bookmark icon (top right) – optional
                    Positioned(
                      top: 40,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.bookmark_border,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // --- EXERCISE CONTENT ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page title
                      const Text(
                        'Exercices – Lettres et Accents Français 1.3',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ====== Exercice 1 ======
                      const Text(
                        'Exercice 1 : Identifiez si chaque lettre est une consonne ou une voyelle.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Les consonnes vont de B à Z (à l\'exception de A, E, I, O, U, H) et les voyelles sont A, E, I, O, U, H.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Lettre',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Consonne',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Voyelle',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: [
                          _buildExercise1Row('D', 'c1'),
                          _buildExercise1Row('A', 'c2'),
                          _buildExercise1Row('S', 'c3'),
                          _buildExercise1Row('O', 'c4'),
                          _buildExercise1Row('E', 'c5'),
                          _buildExercise1Row('T', 'c6'),
                        ],
                        headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => const Color(0xFFE0E0E0),
                        ),
                        dataRowHeight: 56,
                      ),
                      const SizedBox(height: 32),

                      // ====== Exercice 2 ======
                      const Text(
                        'Exercice 2 : Associez chaque accent à sa description et exemple.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choisissez, pour chaque type d’accent, la bonne description/exemple.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      // a. L’accent aigu
                      _buildExercise2Group(
                        questionKey: 'a',
                        questionText: 'a. L’accent aigu',
                        options: const {
                          'é': 'é (été)',
                          'è': 'è (père)',
                          'ü': 'ü (naïf)',
                        },
                      ),
                      const SizedBox(height: 16),
                      // b. L’accent grave
                      _buildExercise2Group(
                        questionKey: 'b',
                        questionText: 'b. L’accent grave',
                        options: const {
                          'à': 'à (là)',
                          'â': 'â (château)',
                          'ç': 'ç (garçon)',
                        },
                      ),
                      const SizedBox(height: 16),
                      // c. La cédille
                      _buildExercise2Group(
                        questionKey: 'c',
                        questionText: 'c. La cédille',
                        options: const {
                          'ç': 'ç (leçon)',
                          'ê': 'ê (forêt)',
                          'é': 'é (marché)',
                        },
                      ),
                      const SizedBox(height: 16),
                      // d. L’accent circonflexe
                      _buildExercise2Group(
                        questionKey: 'd',
                        questionText: 'd. L’accent circonflexe',
                        options: const {
                          'â': 'â (château)',
                          'é': 'é (marché)',
                          'ë': 'ë (Noël)',
                        },
                      ),
                      const SizedBox(height: 16),
                      // e. Le tréma
                      _buildExercise2Group(
                        questionKey: 'e',
                        questionText: 'e. Le tréma',
                        options: const {
                          'ë': 'ë (Noël)',
                          'î': 'î (île)',
                          'é': 'é (été)',
                        },
                      ),
                      const SizedBox(height: 32),

                      // ====== Exercice 3 ======
                      const Text(
                        'Exercice 3 : Complétez les mots suivants avec la bonne lettre accentuée.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Indiquez la lettre exacte (avec accent) dans chaque champ.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      _buildExercise3Field(
                        label: 'a. M_re → ',
                        controller: _exercise3Controllers['w1']!,
                        hint: '?',
                      ),
                      const SizedBox(height: 12),
                      _buildExercise3Field(
                        label: 'b. _le → ',
                        controller: _exercise3Controllers['w2']!,
                        hint: '?',
                      ),
                      const SizedBox(height: 12),
                      _buildExercise3Field(
                        label: 'c. Gar_on → ',
                        controller: _exercise3Controllers['w3']!,
                        hint: '?',
                      ),
                      const SizedBox(height: 12),
                      _buildExercise3Field(
                        label: 'd. H_pital → ',
                        controller: _exercise3Controllers['w4']!,
                        hint: '?',
                      ),
                      const SizedBox(height: 12),
                      _buildExercise3Field(
                        label: 'e. Ambigu_ → ',
                        controller: _exercise3Controllers['w5']!,
                        hint: '?',
                      ),
                      const SizedBox(height: 32),

                      // Vérifier mes réponses button
                      Center(
                        child: ElevatedButton(
                          onPressed: _checkAnswers,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Vérifier mes réponses',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ====== Résultats ======
                      if (_showResults) ...[
                        const Divider(thickness: 1.2),
                        const SizedBox(height: 16),
                        const Text(
                          'Résultats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Exercice 1 – Consonnes/Voyelles : $_score1 / ${_correct1.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Exercice 2 – Types d\'accents : $_score2 / ${_correct2.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Exercice 3 – Complétez les mots : $_score3 / ${_correct3.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildExercise1Row(String letter, String key) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            letter,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Radio<String>(
            value: 'consonne',
            groupValue: _exercise1Answers[key],
            onChanged: (value) {
              setState(() {
                _exercise1Answers[key] = value;
              });
            },
          ),
        ),
        DataCell(
          Radio<String>(
            value: 'voyelle',
            groupValue: _exercise1Answers[key],
            onChanged: (value) {
              setState(() {
                _exercise1Answers[key] = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExercise2Group({
    required String questionKey,
    required String questionText,
    required Map<String, String> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        ...options.entries.map((entry) {
          final value = entry.key;
          final label = entry.value;
          return RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            title: Text(label),
            value: value,
            groupValue: _exercise2Answers[questionKey],
            onChanged: (val) {
              setState(() {
                _exercise2Answers[questionKey] = val;
              });
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildExercise3Field({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    // Find correct accent for hint display
    final accentExample =
        _correct3[_exercise3Controllers.entries
            .firstWhere((c) => c.value == controller)
            .key]!;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            maxLength: 1,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              border: const UnderlineInputBorder(),
            ),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'.'))],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            accentExample,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
