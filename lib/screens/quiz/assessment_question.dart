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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      value: Assessment.interested,
      width: 580,
      height: 160,
      x: 300,
      angle: 10,
      image: 'question_assessment_img_noti',
    ),
    ChooserBox(
      value: Assessment.averted,
      width: 500,
      height: 500,
      x: -50,
      y: 150,
      angle: -10,
      image: 'question_assessment_img_sticky',
    ),
    ChooserBox(
      value: Assessment.neutral,
      width: 550,
      height: 500,
      x: 380,
      y: 180,
      angle: 20,
      image: 'question_assessment_img_paper',
    ),
    ChooserBox(
      value: Assessment.interested,
      width: 400,
      height: 200,
      x: 00,
      y: 650,
      angle: -10,
      image: 'question_assessment_img_message',
    ),
    ChooserBox(
      value: Assessment.averted,
      width: 580,
      height: 297,
      x: 300,
      y: 850,
      angle: -5,
      image: 'question_assessment_img_tweet',
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
              padding: EdgeInsets.symmetric(horizontal: 96.sp),
              child: Stack(
                clipBehavior: Clip.none,
                children: List.generate(_boxes.length, (index) {
                  final box = _boxes[index];
                  return Positioned(
                    left: box.x.sp,
                    top: box.y.sp,
                    width: box.width.w,
                    height: box.height.h,
                    child: Transform.rotate(
                      angle: box.angle * (pi / 360),
                      child: StickerChooserBox(
                        selected: box.selected,
                        image: $s[box.image] ?? '',
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
