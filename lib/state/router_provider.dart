import 'package:enter_bravo_kiosk/screens/calibration.dart';
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
import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

final _routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
    //redirect: (context, state) => '/result',
  ),
  GoRoute(
    path: '/calibration',
    builder: (context, state) => CalibrationScreen(
      from: state.uri.queryParameters['from']?.replaceAll('%2F', '/'),
    ),
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
    path: '/result',
    builder: (context, state) => const ResultScreen(),
  ),
];

@riverpod
GoRouter router(RouterRef ref) {
  final isCalibrating = ValueNotifier<bool>(false);
  ref
    ..onDispose(isCalibrating.dispose)
    ..listen(pointerDeviceStateNotifierProvider, (_, next) {
      isCalibrating.value = next == PointerState.calibrating;
    });

  final isIdle = ValueNotifier<bool>(true);
  ref
    ..onDispose(isIdle.dispose)
    ..listen(pointerDeviceStateNotifierProvider, (_, next) {
      isIdle.value = next == PointerState.idle;
    });

  return GoRouter(
      routes: _routes,
      refreshListenable: Listenable.merge([isCalibrating, isIdle]),
      redirect: (context, state) {
        final from = state.fullPath;

        if (isIdle.value && from != '/') {
          ref.read(questionnaireStateProvider.notifier).reset();
          return '/';
        }

        if (isCalibrating.value && from != '/calibration') {
          if (from == '/') return '/calibration';
          return '/calibration/?from=${from?.replaceAll('/', '%2F')}';
        }

        return null;
      });
}
