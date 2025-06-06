import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class A1Four extends StatefulWidget {
  final String imageUrl;
  const A1Four({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _A1FourState createState() => _A1FourState();
}

class _A1FourState extends State<A1Four> with SingleTickerProviderStateMixin {
  // ====== Color constants ======
  static const Color headerColor = Color(0xFF2c3e50);
  static const Color primaryBlue = Color(0xFF3498db);
  static const Color correctGreen = Color(0xFF2ecc71);
  static const Color wrongRed = Color(0xFFe74c3c);
  static const Color explanationBackground = Color(0xFFecf0f1);

  // ====== Tab labels ======
  final List<Tab> tabs = const [
    Tab(text: 'Sons Muets'),
    Tab(text: 'Exception « Bonjour »'),
    Tab(text: 'Liaison'),
    Tab(text: 'Élision'),
    Tab(text: 'Résultats'),
  ];

  // ====== Tab controller ======
  late TabController _tabController;

  // --- State for "Sons Muets" (3 questions) ---
  int? q1MuetsSelected;
  bool q1MuetsCorrect = false;
  bool q1MuetsAnswered = false;

  int? q2MuetsSelected;
  bool q2MuetsCorrect = false;
  bool q2MuetsAnswered = false;

  int? q3MuetsSelected;
  bool q3MuetsCorrect = false;
  bool q3MuetsAnswered = false;

  // --- State for "Exception Bonjour" (2 questions) ---
  int? q1ExceptionSelected;
  bool q1ExceptionCorrect = false;
  bool q1ExceptionAnswered = false;

  int? q2ExceptionSelected;
  bool q2ExceptionCorrect = false;
  bool q2ExceptionAnswered = false;

  // --- State for "Liaison" (3 questions) ---
  int? q1LiaisonSelected;
  bool q1LiaisonCorrect = false;
  bool q1LiaisonAnswered = false;

  int? q2LiaisonSelected;
  bool q2LiaisonCorrect = false;
  bool q2LiaisonAnswered = false;

  int? q3LiaisonSelected;
  bool q3LiaisonCorrect = false;
  bool q3LiaisonAnswered = false;

  // --- State for "Élision" (3 text questions) ---
  final TextEditingController _q1ElisionController = TextEditingController();
  bool q1ElisionAnswered = false;
  bool q1ElisionCorrect = false;

  final TextEditingController _q2ElisionController = TextEditingController();
  bool q2ElisionAnswered = false;
  bool q2ElisionCorrect = false;

  final TextEditingController _q3ElisionController = TextEditingController();
  bool q3ElisionAnswered = false;
  bool q3ElisionCorrect = false;

  // ====== Lifecycle ======
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _q1ElisionController.dispose();
    _q2ElisionController.dispose();
    _q3ElisionController.dispose();
    super.dispose();
  }

  // ====== Score getters ======
  int get muetsScore =>
      (q1MuetsCorrect ? 1 : 0) +
      (q2MuetsCorrect ? 1 : 0) +
      (q3MuetsCorrect ? 1 : 0);
  int get muetsTotal => 3;

  int get exceptionScore =>
      (q1ExceptionCorrect ? 1 : 0) + (q2ExceptionCorrect ? 1 : 0);
  int get exceptionTotal => 2;

  int get liaisonScore =>
      (q1LiaisonCorrect ? 1 : 0) +
      (q2LiaisonCorrect ? 1 : 0) +
      (q3LiaisonCorrect ? 1 : 0);
  int get liaisonTotal => 3;

  int get elisionScore =>
      (q1ElisionCorrect ? 1 : 0) +
      (q2ElisionCorrect ? 1 : 0) +
      (q3ElisionCorrect ? 1 : 0);
  int get elisionTotal => 3;

  int get globalScore =>
      muetsScore + exceptionScore + liaisonScore + elisionScore;
  int get globalTotal =>
      muetsTotal + exceptionTotal + liaisonTotal + elisionTotal;

  // ====== Reset all questions ======
  void _resetGame() {
    setState(() {
      // Sons Muets
      q1MuetsSelected = null;
      q1MuetsCorrect = false;
      q1MuetsAnswered = false;

      q2MuetsSelected = null;
      q2MuetsCorrect = false;
      q2MuetsAnswered = false;

      q3MuetsSelected = null;
      q3MuetsCorrect = false;
      q3MuetsAnswered = false;

      // Exception
      q1ExceptionSelected = null;
      q1ExceptionCorrect = false;
      q1ExceptionAnswered = false;

      q2ExceptionSelected = null;
      q2ExceptionCorrect = false;
      q2ExceptionAnswered = false;

      // Liaison
      q1LiaisonSelected = null;
      q1LiaisonCorrect = false;
      q1LiaisonAnswered = false;

      q2LiaisonSelected = null;
      q2LiaisonCorrect = false;
      q2LiaisonAnswered = false;

      q3LiaisonSelected = null;
      q3LiaisonCorrect = false;
      q3LiaisonAnswered = false;

      // Élision
      _q1ElisionController.clear();
      q1ElisionAnswered = false;
      q1ElisionCorrect = false;

      _q2ElisionController.clear();
      q2ElisionAnswered = false;
      q2ElisionCorrect = false;

      _q3ElisionController.clear();
      q3ElisionAnswered = false;
      q3ElisionCorrect = false;

      // Back to first tab
      _tabController.index = 0;
    });
  }

  // ====== Handlers for multiple-choice ======
  void _handleMuetsAnswer(int questionNumber, int choice) {
    setState(() {
      switch (questionNumber) {
        case 1:
          if (!q1MuetsAnswered) {
            q1MuetsSelected = choice;
            q1MuetsCorrect = (choice == 2); // 'T' is correct
            q1MuetsAnswered = true;
          }
          break;
        case 2:
          if (!q2MuetsAnswered) {
            q2MuetsSelected = choice;
            q2MuetsCorrect = (choice == 2); // 'S' is correct
            q2MuetsAnswered = true;
          }
          break;
        case 3:
          if (!q3MuetsAnswered) {
            q3MuetsSelected = choice;
            q3MuetsCorrect = (choice == 3); // 'L' is correct
            q3MuetsAnswered = true;
          }
          break;
      }
    });
  }

  void _handleExceptionAnswer(int questionNumber, int choice) {
    setState(() {
      switch (questionNumber) {
        case 1:
          if (!q1ExceptionAnswered) {
            q1ExceptionSelected = choice;
            q1ExceptionCorrect = (choice == 1); // 'Oui' is correct
            q1ExceptionAnswered = true;
          }
          break;
        case 2:
          if (!q2ExceptionAnswered) {
            q2ExceptionSelected = choice;
            q2ExceptionCorrect = (choice == 1); // 'Oui' is correct
            q2ExceptionAnswered = true;
          }
          break;
      }
    });
  }

  void _handleLiaisonAnswer(int questionNumber, int choice) {
    setState(() {
      switch (questionNumber) {
        case 1:
          if (!q1LiaisonAnswered) {
            q1LiaisonSelected = choice;
            q1LiaisonCorrect = (choice == 1); // 'Oui' is correct
            q1LiaisonAnswered = true;
          }
          break;
        case 2:
          if (!q2LiaisonAnswered) {
            q2LiaisonSelected = choice;
            q2LiaisonCorrect = (choice == 2); // 'Non' is correct
            q2LiaisonAnswered = true;
          }
          break;
        case 3:
          if (!q3LiaisonAnswered) {
            q3LiaisonSelected = choice;
            q3LiaisonCorrect = (choice == 2);
            // 'Une liaison entre « suis » et « indien »' is choice 2
            q3LiaisonAnswered = true;
          }
          break;
      }
    });
  }

  // ====== Handlers for text-input ("Élision") ======
  void _handleElisionAnswer(int questionNumber) {
    setState(() {
      switch (questionNumber) {
        case 1:
          if (!q1ElisionAnswered) {
            final answer = _q1ElisionController.text.trim().toLowerCase();
            q1ElisionCorrect = (answer == "l'animal");
            q1ElisionAnswered = true;
          }
          break;
        case 2:
          if (!q2ElisionAnswered) {
            final answer = _q2ElisionController.text.trim().toLowerCase();
            q2ElisionCorrect = (answer == "j'ai amis");
            q2ElisionAnswered = true;
          }
          break;
        case 3:
          if (!q3ElisionAnswered) {
            final answer = _q3ElisionController.text.trim().toLowerCase();
            q3ElisionCorrect = (answer == "vous et ils allez");
            q3ElisionAnswered = true;
          }
          break;
      }
    });
  }

  // ====== Section builders ======
  Widget _buildExplanation(String title, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: explanationBackground,
        border: Border(left: BorderSide(color: primaryBlue, width: 5)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceQuestion({
    required String questionText,
    required List<String> options,
    required int? selectedOption,
    required bool isCorrect,
    required bool isAnswered,
    required ValueChanged<int> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(options.length, (index) {
            final choiceIndex = index + 1;
            final bool isSelected = selectedOption == choiceIndex;
            Color backgroundColor = primaryBlue;

            if (isAnswered && isSelected) {
              backgroundColor = isCorrect ? correctGreen : wrongRed;
            }

            return ElevatedButton(
              onPressed: isAnswered ? null : () => onSelected(choiceIndex),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Text(
                options[index],
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTextQuestion({
    required String questionText,
    required TextEditingController controller,
    required bool isAnswered,
    required bool isCorrect,
    required VoidCallback onValidate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: questionText,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                enabled: !isAnswered,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: isAnswered ? null : onValidate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe67e22),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text(
                'Vérifier',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedbackText(bool isAnswered, bool isCorrect) {
    if (!isAnswered) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        isCorrect ? '✅ Correct !' : '❌ Incorrect.',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isCorrect ? correctGreen : wrongRed,
        ),
      ),
    );
  }

  // ====== Individual section widgets ======

  Widget _buildMuetsSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExplanation(
            "Astuces #1 : Sons Muets",
            "En français, la dernière lettre ou le dernier son consonantique de nombreux "
                "mots ne se prononce pas.\n\nExemple : Salut (le « t » final est muet).",
          ),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 1 : Dans « Salut », quelle lettre finale est muette ?",
            options: const ['S', 'T', 'U', 'L'],
            selectedOption: q1MuetsSelected,
            isCorrect: q1MuetsCorrect,
            isAnswered: q1MuetsAnswered,
            onSelected: (choice) => _handleMuetsAnswer(1, choice),
          ),
          _buildFeedbackText(q1MuetsAnswered, q1MuetsCorrect),
          const SizedBox(height: 16),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 2 : Dans « Paris », quelle lettre finale n'est pas prononcée ?",
            options: const ['P', 'S', 'R', 'I'],
            selectedOption: q2MuetsSelected,
            isCorrect: q2MuetsCorrect,
            isAnswered: q2MuetsAnswered,
            onSelected: (choice) => _handleMuetsAnswer(2, choice),
          ),
          _buildFeedbackText(q2MuetsAnswered, q2MuetsCorrect),
          const SizedBox(height: 16),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 3 : Dans « Montreal » (sans accent), quelle consonne finale est muette ?",
            options: const ['M', 'T', 'L', 'N'],
            selectedOption: q3MuetsSelected,
            isCorrect: q3MuetsCorrect,
            isAnswered: q3MuetsAnswered,
            onSelected: (choice) => _handleMuetsAnswer(3, choice),
          ),
          _buildFeedbackText(q3MuetsAnswered, q3MuetsCorrect),
          const SizedBox(height: 24),
          Text(
            "Score section Sons Muets : $muetsScore / $muetsTotal",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExceptionSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExplanation(
            "Astuces #2 : Exception « Bonjour »",
            "Contrairement aux mots à son muet, dans « Bonjour », le son consonantique "
                "final « r » se prononce.\n\nIl signifie « bonne journée ». Vous devez prononcer le « r » final.",
          ),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 1 : Est-ce que le « r » final de « Bonjour » se prononce ?",
            options: const ['Oui', 'Non'],
            selectedOption: q1ExceptionSelected,
            isCorrect: q1ExceptionCorrect,
            isAnswered: q1ExceptionAnswered,
            onSelected: (choice) => _handleExceptionAnswer(1, choice),
          ),
          _buildFeedbackText(q1ExceptionAnswered, q1ExceptionCorrect),
          const SizedBox(height: 16),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 2 : Le mot « Amour » a-t-il son « r » final prononcé de la même façon ?",
            options: const ['Oui', 'Non'],
            selectedOption: q2ExceptionSelected,
            isCorrect: q2ExceptionCorrect,
            isAnswered: q2ExceptionAnswered,
            onSelected: (choice) => _handleExceptionAnswer(2, choice),
          ),
          _buildFeedbackText(q2ExceptionAnswered, q2ExceptionCorrect),
          const SizedBox(height: 24),
          Text(
            "Score section Exception « Bonjour » : $exceptionScore / $exceptionTotal",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiaisonSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExplanation(
            "Astuces #3 : La Liaison",
            "En français, lorsqu’un mot se termine par une consonne et que le mot suivant "
                "commence par une voyelle, on lie les deux mots pour faciliter la prononciation.\n\n"
                "Exemples : mon ami (prononcé « mon‿ami »).\n"
                "Exemple avec chiffre : neuf œufs (prononcé « n‿œf‿z‿œf »).\n"
                "Autre exemple : Je suis indien (prononcé « Je sui‿z‿indien »).",
          ),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 1 : Y a-t-il une liaison dans « mon ami » ?",
            options: const ['Oui', 'Non'],
            selectedOption: q1LiaisonSelected,
            isCorrect: q1LiaisonCorrect,
            isAnswered: q1LiaisonAnswered,
            onSelected: (choice) => _handleLiaisonAnswer(1, choice),
          ),
          _buildFeedbackText(q1LiaisonAnswered, q1LiaisonCorrect),
          const SizedBox(height: 16),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 2 : Y a-t-il une liaison dans « mon chat » ?",
            options: const ['Oui', 'Non'],
            selectedOption: q2LiaisonSelected,
            isCorrect: q2LiaisonCorrect,
            isAnswered: q2LiaisonAnswered,
            onSelected: (choice) => _handleLiaisonAnswer(2, choice),
          ),
          _buildFeedbackText(q2LiaisonAnswered, q2LiaisonCorrect),
          const SizedBox(height: 16),
          _buildMultipleChoiceQuestion(
            questionText:
                "Question 3 : Dans « Je suis indien », que se passe-t-il ?",
            options: const [
              "Il n’y a pas de liaison",
              "Une liaison entre « suis » et « indien »",
              "Une liaison entre « Je » et « suis »",
              "Une liaison entre « suis » et « Je »",
            ],
            selectedOption: q3LiaisonSelected,
            isCorrect: q3LiaisonCorrect,
            isAnswered: q3LiaisonAnswered,
            onSelected: (choice) => _handleLiaisonAnswer(3, choice),
          ),
          _buildFeedbackText(q3LiaisonAnswered, q3LiaisonCorrect),
          const SizedBox(height: 24),
          Text(
            "Score section Liaison : $liaisonScore / $liaisonTotal",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElisionSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExplanation(
            "Astuces #4 : L’Élision",
            "En français, pour éviter le hiatus (deux voyelles consécutives), on "
                "remplace la voyelle finale d’un mot par une apostrophe si le mot suivant "
                "commence par une voyelle.\n\n"
                "Exemple : Le alphabet devient l’alphabet.",
          ),
          _buildTextQuestion(
            questionText:
                "Question 1 : Complétez correctement : Le ____nimal\n(Le mot à utiliser est « animal ».)",
            controller: _q1ElisionController,
            isAnswered: q1ElisionAnswered,
            isCorrect: q1ElisionCorrect,
            onValidate: () => _handleElisionAnswer(1),
          ),
          _buildFeedbackText(q1ElisionAnswered, q1ElisionCorrect),
          const SizedBox(height: 16),
          _buildTextQuestion(
            questionText:
                "Question 2 : Complétez correctement : Je ai ____s voisins\n(Le mot à utiliser est « amis ».)",
            controller: _q2ElisionController,
            isAnswered: q2ElisionAnswered,
            isCorrect: q2ElisionCorrect,
            onValidate: () => _handleElisionAnswer(2),
          ),
          _buildFeedbackText(q2ElisionAnswered, q2ElisionCorrect),
          const SizedBox(height: 16),
          _buildTextQuestion(
            questionText:
                "Question 3 : Complétez correctement : Vous et ____ allez\n(Le mot à utiliser est « ils ».)",
            controller: _q3ElisionController,
            isAnswered: q3ElisionAnswered,
            isCorrect: q3ElisionCorrect,
            onValidate: () => _handleElisionAnswer(3),
          ),
          _buildFeedbackText(q3ElisionAnswered, q3ElisionCorrect),
          const SizedBox(height: 24),
          Text(
            "Score section Élision : $elisionScore / $elisionTotal",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Votre Score Global',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '$globalScore / $globalTotal',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe67e22),
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
                'Recommencer le Jeu',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====== Main build ======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No default AppBar — use custom header
      body: Stack(
        children: [
          // Header image + back/bookmark overlays
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
          // Bookmark icon (top right) — optional
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

          // Content below header
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Column(
              children: [
                // Custom TabBar
                Container(
                  color: headerColor,
                  child: TabBar(
                    controller: _tabController,
                    tabs: tabs,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Tab views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMuetsSection(),
                      _buildExceptionSection(),
                      _buildLiaisonSection(),
                      _buildElisionSection(),
                      _buildResultsSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
