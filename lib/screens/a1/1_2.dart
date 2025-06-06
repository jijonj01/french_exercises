import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class A1Two extends StatefulWidget {
  const A1Two({Key? key}) : super(key: key);

  @override
  _A1TwoState createState() => _A1TwoState();
}

class _A1TwoState extends State<A1Two> {
  // ====== Exercise 1 state ======
  // Keys: "c1" through "c6", values: "consonne" or "voyelle"
  final Map<String, String?> _exercise1Answers = {
    'c1': null, // C
    'c2': null, // O
    'c3': null, // H
    'c4': null, // Y
    'c5': null, // U
    'c6': null, // B
  };

  // ====== Exercise 2 state ======
  // Keys: "a" through "e", values: one of the provided options
  final Map<String, String?> _exercise2Answers = {
    'a': null, // L’accent aigu
    'b': null, // L’accent grave
    'c': null, // La cédille
    'd': null, // L’accent circonflexe
    'e': null, // Le tréma
  };

  // ====== Exercise 3 state ======
  // Keys: "w1" through "w5", values: single-character input
  final Map<String, TextEditingController> _exercise3Controllers = {
    'w1': TextEditingController(), // Ca_e → É (CAFÉ)
    'w2': TextEditingController(), // H_tel → Ô (HÔTEL)
    'w3': TextEditingController(), // P_te → Â (PÂTÉ)
    'w4': TextEditingController(), // Fen_tre → Ê (FENÊTRE)
    'w5': TextEditingController(), // Bru_le → Û (BRÛLÉ)
  };

  // To display results after checking
  bool _showResults = false;
  int _score1 = 0;
  int _score2 = 0;
  int _score3 = 0;

  // Correct answers for Exercise 1
  final Map<String, String> _correct1 = {
    'c1': 'consonne', // C
    'c2': 'voyelle', // O
    'c3': 'voyelle', // H
    'c4': 'consonne', // Y
    'c5': 'voyelle', // U
    'c6': 'consonne', // B
  };

  // Correct answers for Exercise 2
  final Map<String, String> _correct2 = {
    'a': 'é', // Accent aigu
    'b': 'è', // Accent grave
    'c': 'ç', // Cédille
    'd': 'ô', // Circonflexe
    'e': 'ï', // Tréma
  };

  // Correct answers for Exercise 3
  final Map<String, String> _correct3 = {
    'w1': 'É', // CAFÉ
    'w2': 'Ô', // HÔTEL
    'w3': 'Â', // PÂTÉ
    'w4': 'Ê', // FENÊTRE
    'w5': 'Û', // BRÛLÉ
  };

  // Hints (full word) for Exercise 3
  final Map<String, String> _hints3 = {
    'w1': '(CAFÉ)',
    'w2': '(HÔTEL)',
    'w3': '(PÂTÉ)',
    'w4': '(FENÊTRE)',
    'w5': '(BRÛLÉ)',
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
    // Dispose controllers
    for (final controller in _exercise3Controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercices – Lettres et Accents Français 1.2',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0056B3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== Exercice 1 ======
            const Text(
              'Exercice 1 : Identifiez si chaque lettre est une consonne ou une voyelle.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0056B3),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Les consonnes vont de B à Z (à l\'exception de A, E, I, O, U, H) et les voyelles sont A, E, I, O, U, H.',
            ),
            const SizedBox(height: 12),
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
                _buildExercise1Row('C', 'c1'),
                _buildExercise1Row('O', 'c2'),
                _buildExercise1Row('H', 'c3'),
                _buildExercise1Row('Y', 'c4'),
                _buildExercise1Row('U', 'c5'),
                _buildExercise1Row('B', 'c6'),
              ],
              headingRowColor: MaterialStateProperty.resolveWith(
                (states) => const Color(0xFFE0E0E0),
              ),
              dataRowHeight: 56,
            ),
            const SizedBox(height: 24),

            // ====== Exercice 2 ======
            const Text(
              'Exercice 2 : Associez chaque accent à sa description et exemple.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0056B3),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choisissez, pour chaque type d’accent, la bonne description/exemple.',
            ),
            const SizedBox(height: 12),

            // a. L’accent aigu
            _buildExercise2Group(
              questionKey: 'a',
              questionText: 'a. L’accent aigu',
              options: const {
                'é': 'é (élève)',
                'è': 'è (père)',
                'û': 'û (château)',
              },
            ),
            const SizedBox(height: 12),
            // b. L’accent grave
            _buildExercise2Group(
              questionKey: 'b',
              questionText: 'b. L’accent grave',
              options: const {
                'è': 'è (père)',
                'ç': 'ç (garçon)',
                'ê': 'ê (forêt)',
              },
            ),
            const SizedBox(height: 12),
            // c. La cédille
            _buildExercise2Group(
              questionKey: 'c',
              questionText: 'c. La cédille',
              options: const {
                'ç': 'ç (garçon)',
                'ô': 'ô (hôtel)',
                'ï': 'ï (naïf)',
              },
            ),
            const SizedBox(height: 12),
            // d. L’accent circonflexe
            _buildExercise2Group(
              questionKey: 'd',
              questionText: 'd. L’accent circonflexe',
              options: const {
                'ô': 'ô (hôpital)',
                'é': 'é (marché)',
                'ë': 'ë (Noël)',
              },
            ),
            const SizedBox(height: 12),
            // e. Le tréma
            _buildExercise2Group(
              questionKey: 'e',
              questionText: 'e. Le tréma',
              options: const {
                'ï': 'ï (naïf)',
                'à': 'à (là)',
                'â': 'â (château)',
              },
            ),
            const SizedBox(height: 24),

            // ====== Exercice 3 ======
            const Text(
              'Exercice 3 : Complétez les mots suivants avec la bonne lettre accentuée.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0056B3),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Indiquez la lettre exacte (avec accent) dans chaque champ.',
            ),
            const SizedBox(height: 12),
            _buildExercise3Field(
              label: 'a. Ca_e → ',
              controller: _exercise3Controllers['w1']!,
              hintText: _hints3['w1']!,
            ),
            const SizedBox(height: 8),
            _buildExercise3Field(
              label: 'b. H_tel → ',
              controller: _exercise3Controllers['w2']!,
              hintText: _hints3['w2']!,
            ),
            const SizedBox(height: 8),
            _buildExercise3Field(
              label: 'c. P_te → ',
              controller: _exercise3Controllers['w3']!,
              hintText: _hints3['w3']!,
            ),
            const SizedBox(height: 8),
            _buildExercise3Field(
              label: 'd. Fen_tre → ',
              controller: _exercise3Controllers['w4']!,
              hintText: _hints3['w4']!,
            ),
            const SizedBox(height: 8),
            _buildExercise3Field(
              label: 'e. Bru_le → ',
              controller: _exercise3Controllers['w5']!,
              hintText: _hints3['w5']!,
            ),
            const SizedBox(height: 24),

            // Vérifier mes réponses button
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0056B3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Vérifier mes réponses',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ====== Résultats ======
            if (_showResults) ...[
              const Divider(thickness: 1.2),
              const SizedBox(height: 12),
              const Text(
                'Résultats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0056B3),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Exercice 1 – Consonnes/Voyelles : $_score1 / ${_correct1.length}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Exercice 2 – Types d\'accents : $_score2 / ${_correct2.length}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Exercice 3 – Complétez les mots : $_score3 / ${_correct3.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    required String hintText,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              hintText: '?',
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
            hintText,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
