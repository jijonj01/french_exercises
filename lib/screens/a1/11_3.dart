import 'dart:async';
import 'package:flutter/material.dart';
import 'package:french_exercises/screens/a1/11_1.dart';
import 'package:french_exercises/screens/header.dart';

class A1TwentyFive extends StatefulWidget {
  final String imageUrl;
  const A1TwentyFive({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1TwentyFiveState createState() => _A1TwentyFiveState();
}

class _A1TwentyFiveState extends State<A1TwentyFive> {
  // Exercice 1 selections
  String? q1, q2, q3, q4, q5, q6;

  // Exercice 2 controllers
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
    'q1': 'mardi10',
    'q2': 'mercredi12',
    'q3': 'jeudi14',
    'q4': 'vendredi19',
    'q5': 'samedi20',
    'q6': 'dimanche9',
  };
  final _answers2 = {
    'm1': 'SEPTEMBRE',
    'm2': 'NOVEMBRE',
    'm3': 'FEVRIER',
    'm4': 'JUILLET',
    'm5': 'OCTOBRE',
    'm6': 'MARS',
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
    var count1 = 0;
    if (q1 == _answers1['q1']) count1++;
    if (q2 == _answers1['q2']) count1++;
    if (q3 == _answers1['q3']) count1++;
    if (q4 == _answers1['q4']) count1++;
    if (q5 == _answers1['q5']) count1++;
    if (q6 == _answers1['q6']) count1++;

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
    final days = ['L 15', 'M 16', 'M 17', 'J 18', 'V 19', 'S 20', 'D 21'];
    final events = {
      0: '7 h\nCours de yoga',
      1: '10 h\nRendez-vous chez le dentiste',
      2: '12 h\nDéjeuner d’affaires',
      3: '14 h\nRéunion d’équipe',
      4: '19 h\nThéâtre',
      5: '20 h\nAnniversaire chez Léa',
      6: '9 h\nRandonnée en forêt',
    };

    return Table(
      border: TableBorder.all(color: Colors.black54),
      children: [
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                'Octobre',
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
          children: List.generate(
            7,
            (i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(events[i]!, textAlign: TextAlign.center),
            ),
          ),
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
        ...options.map(
          (opt) => RadioListTile<String>(
            title: Text(opt['label']!),
            value: opt['value']!,
            groupValue: groupValue,
            onChanged: onChanged,
            dense: true,
          ),
        ),
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
                  SectionContainer(
                    title: 'Exercice 1 : Observez l’agenda de Nathan',
                    instructions:
                        'Cochez les bonnes réponses selon l’agenda ci-dessous.',
                    child: Column(
                      children: [
                        _buildCalendarTable(),
                        const SizedBox(height: 16),
                        _buildRadioQuestion(
                          'a. rendez-vous chez le dentiste.',
                          q1,
                          (v) => setState(() => q1 = v),
                          [
                            {'label': 'mardi 16 à 10 h', 'value': 'mardi10'},
                            {
                              'label': 'mercredi 17 à 10 h',
                              'value': 'mercredi10',
                            },
                            {'label': 'jeudi 18 à 10 h', 'value': 'jeudi10'},
                          ],
                        ),
                        _buildRadioQuestion(
                          'b. déjeune d’affaires.',
                          q2,
                          (v) => setState(() => q2 = v),
                          [
                            {
                              'label': 'mercredi 17 à 12 h',
                              'value': 'mercredi12',
                            },
                            {'label': 'mardi 16 à 12 h', 'value': 'mardi12'},
                            {
                              'label': 'vendredi 19 à 12 h',
                              'value': 'vendredi12',
                            },
                          ],
                        ),
                        _buildRadioQuestion(
                          'c. réunion d’équipe.',
                          q3,
                          (v) => setState(() => q3 = v),
                          [
                            {'label': 'jeudi 18 à 14 h', 'value': 'jeudi14'},
                            {
                              'label': 'mercredi 17 à 14 h',
                              'value': 'mercredi14',
                            },
                            {
                              'label': 'vendredi 19 à 14 h',
                              'value': 'vendredi14',
                            },
                          ],
                        ),
                        _buildRadioQuestion(
                          'd. va au théâtre.',
                          q4,
                          (v) => setState(() => q4 = v),
                          [
                            {
                              'label': 'vendredi 19 à 19 h',
                              'value': 'vendredi19',
                            },
                            {'label': 'samedi 20 à 19 h', 'value': 'samedi19'},
                            {
                              'label': 'dimanche 21 à 19 h',
                              'value': 'dimanche19',
                            },
                          ],
                        ),
                        _buildRadioQuestion(
                          'e. anniversaire chez Léa.',
                          q5,
                          (v) => setState(() => q5 = v),
                          [
                            {'label': 'samedi 20 à 20 h', 'value': 'samedi20'},
                            {
                              'label': 'vendredi 19 à 20 h',
                              'value': 'vendredi20',
                            },
                            {
                              'label': 'dimanche 21 à 20 h',
                              'value': 'dimanche20',
                            },
                          ],
                        ),
                        _buildRadioQuestion(
                          'f. randonnée en forêt.',
                          q6,
                          (v) => setState(() => q6 = v),
                          [
                            {
                              'label': 'dimanche 21 à 9 h',
                              'value': 'dimanche9',
                            },
                            {'label': 'samedi 20 à 9 h', 'value': 'samedi9'},
                            {'label': 'lundi 15 à 9 h', 'value': 'lundi9'},
                          ],
                        ),
                      ],
                    ),
                  ),
                  SectionContainer(
                    title: 'Exercice 2 : Retrouvez les mois de l’année',
                    instructions:
                        'Complétez chaque mot en majuscules (sans accents).',
                    child: Column(
                      children: [
                        _buildTextQuestion('a. S _ P T E M B R E →', _m1, 9),
                        const SizedBox(height: 8),
                        _buildTextQuestion('b. N _ V E M B R E →', _m2, 8),
                        const SizedBox(height: 8),
                        _buildTextQuestion('c. F _ V R I E R →', _m3, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('d. J _ I U _ T →', _m4, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('e. O _ T O B R E →', _m5, 7),
                        const SizedBox(height: 8),
                        _buildTextQuestion('f. M _ R S →', _m6, 4),
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
