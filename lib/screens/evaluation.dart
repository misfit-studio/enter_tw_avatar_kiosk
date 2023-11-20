import 'dart:async';

import 'package:enter_bravo_kiosk/components/continuous_animated_rotation.dart';
import 'package:enter_bravo_kiosk/screens/quiz/proficiency_question.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EvaluationScreen extends ConsumerStatefulWidget {
  const EvaluationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EvaluationScreenState();
}

class _EvaluationScreenState extends ConsumerState<EvaluationScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 3000), () {
      context.go('/result');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ContinuousAnimatedRotation(
          duration: const Duration(seconds: 3),
          child: SvgPicture.asset(
            'assets/icons/enter_icon.svg',
            width: 128,
            height: 128,
          ),
        ),
      ),
    );
  }
}
