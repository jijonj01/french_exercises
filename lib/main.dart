import 'package:flutter/material.dart';
import 'package:french_exercises/router/app_router.dart';

void main() {
  runApp(const BrainBoosterApp());
}

class BrainBoosterApp extends StatelessWidget {
  const BrainBoosterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Brain Booster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7F3),
        fontFamily: 'Roboto',
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
