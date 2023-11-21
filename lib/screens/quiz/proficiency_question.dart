import 'dart:math';

import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/components/continuous_animated_rotation.dart';
import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProficiencyQuestion extends HookConsumerWidget {
  const ProficiencyQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);
    final selectedProficiency = useState<Proficiency?>(null);

    onSubmit() {
      ref
          .read(questionnaireStateProvider.notifier)
          .submitAnswer(proficiency: selectedProficiency.value!);

      context.go('/quiz/assessment');
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.green,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_proficiency_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 96.sp),
              child: Stack(
                children: [
                  GravityCircles(index: selectedProficiency.value?.index ?? -1),
                  Center(
                    child: SizedBox(
                      width: 180.sp,
                      child: EnterContainerButton(
                        onTap: () {
                          selectedProficiency.value = Proficiency.nerd;
                        },
                        borderColor:
                            selectedProficiency.value == Proficiency.nerd
                                ? Colors.black
                                : null,
                        child: Text(
                          $s['question_proficiency_label_me'] ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 80.sp,
                    top: 360.sp,
                    width: 280.w,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedProficiency.value = Proficiency.interested;
                      },
                      borderColor:
                          selectedProficiency.value == Proficiency.interested
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_proficiency_label_family'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 510.sp,
                    top: 720.sp,
                    width: 280.w,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedProficiency.value = Proficiency.interested;
                      },
                      borderColor:
                          selectedProficiency.value == Proficiency.interested
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_proficiency_label_friends'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 190.sp,
                    top: 930.sp,
                    width: 220.w,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedProficiency.value = Proficiency.casual;
                      },
                      borderColor:
                          selectedProficiency.value == Proficiency.casual
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_proficiency_label_life'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          QuestionFooter(
            disableSubmit: selectedProficiency.value == null,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

class GravityCircles extends StatelessWidget {
  final int index;

  const GravityCircles({
    super.key,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final showPlanet = index >= 0;

    return Stack(
      children: [
        Center(
          child: Container(
            width: 856.w,
            height: 856.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 10.sp,
              ),
              borderRadius: BorderRadius.circular(888.sp),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 588.w,
            height: 588.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 10.sp,
              ),
              borderRadius: BorderRadius.circular(888),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 324.w,
            height: 324.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 10.sp,
              ),
              borderRadius: BorderRadius.circular(888.sp),
            ),
          ),
        ),
        if (showPlanet)
          Center(
            child: ContinuousAnimatedRotation(
              duration: const Duration(seconds: 3),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: index * 132.sp,
                  ),
                  Container(
                    width: 48.sp,
                    height: 48.sp,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(888.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
