import 'package:flutter/material.dart';
import 'package:french_exercises/screens/a1/1_1.dart';
import 'package:french_exercises/screens/a1/1_2.dart';
import 'package:french_exercises/screens/a1/1_3.dart';
import 'package:french_exercises/screens/a1/2_1.dart';
import 'package:go_router/go_router.dart';
import 'package:french_exercises/screens/about.dart';
import 'package:french_exercises/screens/home.dart';
import 'package:french_exercises/screens/course.dart';
import 'package:french_exercises/screens/home_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => HomeShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(builder: (context, state) => const Home(), path: '/home'),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(builder: (context, state) => const About(), path: '/about'),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: '/home',
    //   name: 'home',
    //   builder: (context, state) => const MainPage(),
    // ),
    GoRoute(
      path: '/course/:title',
      name: 'course',
      builder: (context, state) {
        final title = state.pathParameters['title']!;
        final imageUrl = state.uri.queryParameters['imageUrl'] ?? '';
        return CourseDetailPage(course: title, imageUrl: imageUrl);
      },
    ),
    GoRoute(
      path: '/a1exercise/:exerciseNumber',
      name: 'a1exercise',
      builder: (context, state) {
        final exerciseNumber = state.pathParameters['exerciseNumber']!;

        switch (exerciseNumber) {
          case '1':
            return A1One();
          case '2':
            return A1Two();
          case '3':
            return A1Three();
          case '4':
            return A1Four();
          default:
            // Handle invalid exercise numbers
            return const Scaffold(
              body: Center(child: Text('Exercise not found')),
            );
        }
      },
    ),
  ],
);
