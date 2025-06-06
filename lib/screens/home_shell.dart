import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:french_exercises/screens/bottom_nav.dart';

class HomeShell extends StatelessWidget {
  final StatefulNavigationShell shell;

  const HomeShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          shell,
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(shell: shell),
          ),
        ],
      ),
    );
  }
}
