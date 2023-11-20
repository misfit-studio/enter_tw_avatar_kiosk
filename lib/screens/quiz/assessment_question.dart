import 'dart:math';

import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/components/sticker_chooser_box.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:enter_bravo_kiosk/utils/chooser_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssessmentQuestion extends StatefulHookConsumerWidget {
  const AssessmentQuestion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssessmentQuestionState();
}

class _AssessmentQuestionState extends ConsumerState<AssessmentQuestion> {
  final _boxes = <ChooserBox<Assessment>>[
    ChooserBox(
      value: Assessment.averted,
      width: 580,
      height: 297,
      angle: 0,
      image: 'assets/images/assessment_tweet_de.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(selectedLanguageProvider);
    final $s = ref.watch(intlStringsProvider);
    final selectedCount = _boxes.where((box) => box.selected).length;

    onSubmit() {
      if (selectedCount > 0) {
        final selectedBox = _boxes.firstWhere((box) => box.selected);
        final selectedAssessment = selectedBox.value;

        ref
            .read(questionnaireStateProvider.notifier)
            .submitAnswer(assessment: selectedAssessment);

        context.go('/quiz/broadness');
      }
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.turquoise,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_assessment_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 96.0),
              child: Stack(
                children: List.generate(_boxes.length, (index) {
                  final box = _boxes[index];
                  return Positioned(
                    left: box.x,
                    top: box.y,
                    width: box.width,
                    height: box.height,
                    child: Transform.rotate(
                      angle: box.angle * (180 / pi),
                      child: StickerChooserBox(
                        selected: box.selected,
                        image: box.image,
                        onTap: () {
                          // Deselect others
                          for (final box in _boxes) {
                            box.selected = false;
                          }
                          box.selected = true;
                          setState(() {});
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          QuestionFooter(
            disableSubmit: selectedCount == 0,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}
