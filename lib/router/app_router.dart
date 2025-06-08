import 'package:flutter/material.dart';
import 'package:french_exercises/screens/a1/10_1.dart';
import 'package:french_exercises/screens/a1/10_2.dart';
import 'package:french_exercises/screens/a1/10_3.dart';
import 'package:french_exercises/screens/a1/11_1.dart';
import 'package:french_exercises/screens/a1/11_2.dart';
import 'package:french_exercises/screens/a1/11_3.dart';
import 'package:french_exercises/screens/a1/1_1.dart';
import 'package:french_exercises/screens/a1/1_2.dart';
import 'package:french_exercises/screens/a1/1_3.dart';
import 'package:french_exercises/screens/a1/2_1.dart';
import 'package:french_exercises/screens/a1/2_2.dart';
import 'package:french_exercises/screens/a1/2_3.dart';
import 'package:french_exercises/screens/a1/3_1.dart';
import 'package:french_exercises/screens/a1/3_2.dart';
import 'package:french_exercises/screens/a1/3_3.dart';
import 'package:french_exercises/screens/a1/4_1.dart';
import 'package:french_exercises/screens/a1/5_1.dart';
import 'package:french_exercises/screens/a1/5_2.dart';
import 'package:french_exercises/screens/a1/6_1.dart';
import 'package:french_exercises/screens/a1/6_2.dart';
import 'package:french_exercises/screens/a1/7_1.dart';
import 'package:french_exercises/screens/a1/7_2.dart';
import 'package:french_exercises/screens/a1/8_1.dart';
import 'package:french_exercises/screens/a1/8_2.dart';
import 'package:french_exercises/screens/a1/9_1.dart';
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
        final imageUrl = state.uri.queryParameters['imageUrl'] ?? '';
        switch (exerciseNumber) {
          case '1':
            return A1One(imageUrl: imageUrl);
          case '2':
            return A1Two(imageUrl: imageUrl);
          case '3':
            return A1Three(imageUrl: imageUrl);
          case '4':
            return A1Four(imageUrl: imageUrl);
          case '5':
            return A1Five(imageUrl: imageUrl);
          case '6':
            return A1Six(imageUrl: imageUrl);
          case '7':
            return A1Seven(imageUrl: imageUrl);
          case '8':
            return A1Eight(imageUrl: imageUrl);
          case '9':
            return A1Nine(imageUrl: imageUrl);
          case '10':
            return A1Ten();
          case '11':
            return A1Eleven(imageUrl: imageUrl);
          case '12':
            return A1Twelve(imageUrl: imageUrl);
          case '13':
            return A1Thirteen();
          case '14':
            return A1Fourteen();
          case '15':
            return A1Fifteen();
          case '16':
            return A1Sixteen();
          case '17':
            return A1Seventeen();
          case '18':
            return A1Eighteen();
          case '19':
            return A1Nineteen();
          case '20':
            return A1Twenty();
          case '21':
            return A1TwentyOne();
          case '22':
            return A1TwentyTwo();
          case '23':
            return A1TwentyThree(imageUrl: imageUrl);
          case '24':
            return A1TwentyFour(imageUrl: imageUrl);
          case '25':
            return A1TwentyFive(imageUrl: imageUrl);
          // case '26':
          //   return A1TwentySix();
          // case '27':
          //   return A1TwentySeven();
          // case '28':
          //   return A1TwentyEight();
          // case '29':
          //   return A1TwentyNine();
          // case '30':
          //   return A1Thirty();
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
