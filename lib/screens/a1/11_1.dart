import 'dart:async';

import 'package:flutter/material.dart';
import 'package:french_exercises/screens/header.dart';

/// Model for a drop-in section container
class SectionContainer extends StatelessWidget {
  final String title;
  final String instructions;
  final Widget child;

  const SectionContainer({
    Key? key,
    required this.title,
    required this.instructions,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          child,
        ],
      ),
    );
  }
}

class A1TwentyThree extends StatefulWidget {
  final String imageUrl;
  const A1TwentyThree({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1TwentyThreeState createState() => _A1TwentyThreeState();
}

class _A1TwentyThreeState extends State<A1TwentyThree> {
  // --- Exercice 1 state ---
  String? q1, q2, q3, q4;

  // --- Exercice 2 state ---
  final _m1 = TextEditingController();
  final _m2 = TextEditingController();
  final _m3 = TextEditingController();
  final _m4 = TextEditingController();
  final _m5 = TextEditingController();
  final _m6 = TextEditingController();

  // Scores
  int _score1 = 0, _score2 = 0;

  // Correct answers
  final _answers1 = {
    'q1': 'mercredi14',
    'q2': 'vendredi18',
    'q3': 'samedi19',
    'q4': 'dimanche10',
  };

  final _answers2 = {
    'm1': 'AVRIL',
    'm2': 'JUIN',
    'm3': 'MAI',
    'm4': 'OCTOBRE',
    'm5': 'FEVRIER',
    'm6': 'JUILLET',
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
    // Exercice 1
    var count1 = 0;
    if (q1 == _answers1['q1']) count1++;
    if (q2 == _answers1['q2']) count1++;
    if (q3 == _answers1['q3']) count1++;
    if (q4 == _answers1['q4']) count1++;

    // Exercice 2
    var count2 = 0;
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
      if (norm == _answers2[key]) count2++;
    });

    setState(() {
      _score1 = count1;
      _score2 = count2;
    });
  }

  Widget _buildCalendarTable() {
    final days = ['L 1', 'M 2', 'M 3', 'J 4', 'V 5', 'S 6', 'D 7'];
    final events = {
      0: '8 h 30\nMédecin',
      2: '14 h\nRéunion',
      4: '18 h\nCours de gym',
      5: '19 h\nDîner au resto',
      6: '10 h\nMatch de foot',
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
                'Novembre',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            for (var i = 0; i < 6; i++) const SizedBox.shrink(),
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
              child: Text(events[i] ?? '', textAlign: TextAlign.center),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRadioQuestion(
    String label,
    String groupValue,
    String? selectedValue,
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
            groupValue: selectedValue,
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
    int maxLength,
  ) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: ctrl,
            maxLength: maxLength,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              counterText: '',
              hintText: '_' * maxLength,
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
                    title: 'Exercice 1 : Observez l’agenda de Thomas',
                    instructions:
                        'Cochez les bonnes réponses selon l’agenda ci-dessous.',
                    child: Column(
                      children: [
                        _buildCalendarTable(),
                        const SizedBox(height: 16),
                        _buildRadioQuestion(
                          'a. Réunion',
                          'q1',
                          q1,
                          (v) => setState(() => q1 = v),
                          [
                            {'label': 'mardi à 14 h', 'value': 'mardi14'},
                            {'label': 'mercredi à 14 h', 'value': 'mercredi14'},
                            {'label': 'jeudi à 10 h', 'value': 'jeudi10'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'b. Sport',
                          'q2',
                          q2,
                          (v) => setState(() => q2 = v),
                          [
                            {'label': 'vendredi à 18 h', 'value': 'vendredi18'},
                            {'label': 'samedi à 8 h', 'value': 'samedi8'},
                            {'label': 'dimanche à 10 h', 'value': 'dimanche10'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'c. Dîner',
                          'q3',
                          q3,
                          (v) => setState(() => q3 = v),
                          [
                            {'label': 'samedi à 19 h', 'value': 'samedi19'},
                            {'label': 'dimanche à 20 h', 'value': 'dimanche20'},
                            {'label': 'vendredi à 19 h', 'value': 'vendredi19'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'd. Match de foot',
                          'q4',
                          q4,
                          (v) => setState(() => q4 = v),
                          [
                            {'label': 'dimanche à 10 h', 'value': 'dimanche10'},
                            {'label': 'samedi à 14 h', 'value': 'samedi14'},
                            {'label': 'mardi à 10 h', 'value': 'mardi10'},
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
                        _buildTextQuestion('a. A _ _ _ _ →', _m1, 5),
                        const SizedBox(height: 8),
                        _buildTextQuestion('b. J _ _ _ →', _m2, 4),
                        const SizedBox(height: 8),
                        _buildTextQuestion('c. M _ _ →', _m3, 3),
                        const SizedBox(height: 8),
                        _buildTextQuestion('d. O _ _ _ _ _ _ →', _m4, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('e. F _ _ V R I E R →', _m5, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('f. J _ _ _ _ _ _ →', _m6, 7),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _checkAnswers,
                          child: const Text('Vérifier mes réponses'),
                        ),
                        if (_score1 + _score2 > 0) ...[
                          const SizedBox(height: 20),
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
