import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RelianceQuestion extends ConsumerWidget {
  const RelianceQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);

    onSubmit() {
      ref
          .read(questionnaireStateProvider.notifier)
          .submitAnswer(reliance: Reliance.high);

      context.go('/quiz/presentation');
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.purple,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_reliance_title'] ?? '',
          ),
          const Spacer(),
          QuestionFooter(
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}
