import 'dart:async';
import 'package:flutter/material.dart';
import 'package:french_exercises/screens/a1/11_1.dart';
import 'package:french_exercises/screens/header.dart';

/// A Flutter screen replicating the HTML lexique exercises as a game
class A1TwentyFour extends StatefulWidget {
  final String imageUrl;
  const A1TwentyFour({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1TwentyFourState createState() => _A1TwentyFourState();
}

class _A1TwentyFourState extends State<A1TwentyFour> {
  // --- Exercice 1 state ---
  String? q1, q2, q3, q4, q5, q6;

  // --- Exercice 2 state ---
  final _m1 = TextEditingController();
  final _m2 = TextEditingController();
  final _m3 = TextEditingController();
  final _m4 = TextEditingController();
  final _m5 = TextEditingController();
  final _m6 = TextEditingController();

  // Scores
  int _score1 = 0, _score2 = 0;

  // Correct answers mapping keys to normalized values
  final _answers1 = {
    'q1': 'mardi11',
    'q2': 'mercredi12',
    'q3': 'jeudi15',
    'q4': 'vendredi18',
    'q5': 'samedi20',
    'q6': 'dimanche10',
  };
  final _answers2 = {
    'm1': 'NOVEMBRE',
    'm2': 'AOUT',
    'm3': 'JUILLET',
    'm4': 'FEVRIER',
    'm5': 'MARS',
    'm6': 'JANVIER',
  };

  String removeDiacritics(String str) {
    const withDia = 'ÀÁÂÃÄÅàáâãäåÇçÈÉÊËèéêëÌÍÎÏìíîïÐðÑñÒÓÔÕÖØòóôõöøÙÚÛÜùúûüÝýÿ';
    const withoutDia =
        'AAAAAAaaaaaaCcEEEEeeeeIIIIiiiiDdNnOOOOOOooooooUUUUuuuuYyy';
    for (var i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  void _checkAnswers() {
    // Count Exercice 1
    var c1 = 0;
    if (q1 == _answers1['q1']) c1++;
    if (q2 == _answers1['q2']) c1++;
    if (q3 == _answers1['q3']) c1++;
    if (q4 == _answers1['q4']) c1++;
    if (q5 == _answers1['q5']) c1++;
    if (q6 == _answers1['q6']) c1++;

    // Count Exercice 2
    var c2 = 0;
    final inputs = {
      'm1': _m1.text,
      'm2': _m2.text,
      'm3': _m3.text,
      'm4': _m4.text,
      'm5': _m5.text,
      'm6': _m6.text,
    };
    inputs.forEach((key, value) {
      final norm = removeDiacritics(value.trim()).toUpperCase();
      if (norm == _answers2[key]) c2++;
    });

    setState(() {
      _score1 = c1;
      _score2 = c2;
    });
  }

  Widget _buildCalendarTable() {
    final days = ['L 8', 'M 9', 'M 10', 'J 11', 'V 12', 'S 13', 'D 14'];
    final events = {
      0: '9 h\nCours de français',
      1: '11 h\nRendez-vous chez l’opticien',
      2: '12 h\nDéjeuner en famille',
      3: '15 h\nRéunion projet',
      4: '18 h\nCinéma',
      5: '20 h\nFête chez Emma',
      6: '10 h\nJogging',
    };

    return Table(
      border: TableBorder.all(color: Colors.black54),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                'Décembre',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            for (int i = 0; i < 6; i++) const SizedBox.shrink(),
          ],
        ),
        TableRow(
          children:
              days
                  .map(
                    (d) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        d,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  .toList(),
        ),
        TableRow(
          children: List.generate(7, (i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(events[i]!, textAlign: TextAlign.center),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRadioQuestion(
    String label,
    String? groupValue,
    ValueChanged<String?> onChanged,
    List<Map<String, String>> options,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...options.map((opt) {
          return RadioListTile<String>(
            title: Text(opt['label']!),
            value: opt['value']!,
            groupValue: groupValue,
            onChanged: onChanged,
            dense: true,
          );
        }),
      ],
    );
  }

  Widget _buildTextQuestion(
    String label,
    TextEditingController ctrl,
    int maxLen,
  ) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: ctrl,
            maxLength: maxLen,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              counterText: '',
              hintText: '_' * maxLen,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _m1.dispose();
    _m2.dispose();
    _m3.dispose();
    _m4.dispose();
    _m5.dispose();
    _m6.dispose();
    super.dispose();
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
                  const SizedBox(height: 220),
                  // Exercice 1
                  SectionContainer(
                    title: 'Exercice 1 : Observez l’agenda de Camille',
                    instructions:
                        'Cochez les bonnes réponses selon l’agenda ci-dessous.',
                    child: Column(
                      children: [
                        _buildCalendarTable(),
                        const SizedBox(height: 16),
                        _buildRadioQuestion(
                          'a. Camille a un rendez-vous chez l’opticien.',
                          q1,
                          (v) => setState(() => q1 = v),
                          [
                            {'label': 'lundi à 11 h', 'value': 'lundi11'},
                            {'label': 'mardi à 11 h', 'value': 'mardi11'},
                            {'label': 'mercredi à 11 h', 'value': 'mercredi11'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'b. Camille déjeune en famille.',
                          q2,
                          (v) => setState(() => q2 = v),
                          [
                            {'label': 'mercredi à 12 h', 'value': 'mercredi12'},
                            {'label': 'mardi à 12 h', 'value': 'mardi12'},
                            {'label': 'vendredi à 12 h', 'value': 'vendredi12'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'c. Camille a une réunion de projet.',
                          q3,
                          (v) => setState(() => q3 = v),
                          [
                            {'label': 'jeudi à 15 h', 'value': 'jeudi15'},
                            {'label': 'vendredi à 15 h', 'value': 'vendredi15'},
                            {'label': 'samedi à 15 h', 'value': 'samedi15'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'd. Camille va au cinéma.',
                          q4,
                          (v) => setState(() => q4 = v),
                          [
                            {'label': 'vendredi à 18 h', 'value': 'vendredi18'},
                            {'label': 'samedi à 18 h', 'value': 'samedi18'},
                            {'label': 'dimanche à 18 h', 'value': 'dimanche18'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'e. Camille va à une fête.',
                          q5,
                          (v) => setState(() => q5 = v),
                          [
                            {'label': 'samedi à 20 h', 'value': 'samedi20'},
                            {'label': 'dimanche à 20 h', 'value': 'dimanche20'},
                            {'label': 'vendredi à 20 h', 'value': 'vendredi20'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'f. Camille fait du jogging.',
                          q6,
                          (v) => setState(() => q6 = v),
                          [
                            {'label': 'dimanche à 10 h', 'value': 'dimanche10'},
                            {'label': 'vendredi à 10 h', 'value': 'vendredi10'},
                            {'label': 'lundi à 10 h', 'value': 'lundi10'},
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Exercice 2
                  SectionContainer(
                    title: 'Exercice 2 : Retrouvez les mois de l’année',
                    instructions:
                        'Complétez chaque mot en majuscules (sans accents).',
                    child: Column(
                      children: [
                        _buildTextQuestion('a. N _ V E M B R E →', _m1, 8),
                        const SizedBox(height: 8),
                        _buildTextQuestion('b. A _ U T →', _m2, 4),
                        const SizedBox(height: 8),
                        _buildTextQuestion('c. J _ I L L E T →', _m3, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('d. F _ V R I E R →', _m4, 8),
                        const SizedBox(height: 8),
                        _buildTextQuestion('e. M _ R S →', _m5, 4),
                        const SizedBox(height: 8),
                        _buildTextQuestion('f. J _ N V I E R →', _m6, 7),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _checkAnswers,
                          child: const Text('Vérifier mes réponses'),
                        ),
                        if (_score1 + _score2 > 0) ...[
                          const SizedBox(height: 16),
                          Card(
                            color: Colors.lightBlue.shade50,
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Résultats',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Exercice 1 : $_score1 / ${_answers1.length}',
                                  ),
                                  Text(
                                    'Exercice 2 : $_score2 / ${_answers2.length}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
