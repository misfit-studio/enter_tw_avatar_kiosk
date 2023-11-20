import 'package:enter_bravo_kiosk/screens/calibration.dart';
import 'package:enter_bravo_kiosk/screens/evaluation.dart';
import 'package:enter_bravo_kiosk/screens/home.dart';
import 'package:enter_bravo_kiosk/screens/language.dart';
import 'package:enter_bravo_kiosk/screens/quiz/assessment_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/broadness_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/generation_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/interest_type_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/presentation_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/proficiency_question.dart';
import 'package:enter_bravo_kiosk/screens/quiz/reliance_question.dart';
import 'package:enter_bravo_kiosk/screens/result.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      //redirect: (context, state) => '/result',
    ),
    GoRoute(
      path: '/calibration',
      builder: (context, state) => const CalibrationScreen(),
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: '/quiz',
      redirect: (context, state) => '/quiz/generation',
    ),
    GoRoute(
      path: '/quiz/generation',
      builder: (context, state) => const GenerationQuestion(),
    ),
    GoRoute(
      path: '/quiz/interest_type',
      builder: (context, state) => const InterestTypeQuestion(),
    ),
    GoRoute(
      path: '/quiz/proficiency',
      builder: (context, state) => const ProficiencyQuestion(),
    ),
    GoRoute(
      path: '/quiz/assessment',
      builder: (context, state) => const AssessmentQuestion(),
    ),
    GoRoute(
      path: '/quiz/broadness',
      builder: (context, state) => const BroadnessQuestion(),
    ),
    GoRoute(
      path: '/quiz/reliance',
      builder: (context, state) => const RelianceQuestion(),
    ),
    GoRoute(
      path: '/quiz/presentation',
      builder: (context, state) => const PresentationQuestion(),
    ),
    GoRoute(
      path: '/evaluation',
      builder: (context, state) => const EvaluationScreen(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) => const ResultScreen(),
    ),
  ],
);
