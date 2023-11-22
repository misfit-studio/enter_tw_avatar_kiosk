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

class InterestTypeQuestion extends StatefulHookConsumerWidget {
  const InterestTypeQuestion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InterestTypeQuestionState();
}

class _InterestTypeQuestionState extends ConsumerState<InterestTypeQuestion> {
  final _boxes = <ChooserBox<InterestType>>[
    ChooserBox(
      value: InterestType.creativity,
      width: 300,
      height: 300,
      angle: 0,
      image: 'assets/images/interest_type/interest_type_creative_1.png',
    ),
    ChooserBox(
      value: InterestType.creativity,
      width: 300,
      height: 300,
      x: 600,
      y: 400,
      angle: 0,
      image: 'assets/images/interest_type/interest_type_creative_2.png',
    ),
    ChooserBox(
      value: InterestType.creativity,
      width: 400,
      height: 300,
      x: 450,
      angle: 12,
      image: 'assets/images/interest_type/interest_type_creative_3.png',
    ),
    ChooserBox(
      value: InterestType.play,
      width: 300,
      height: 300,
      x: 000,
      y: 380,
      angle: 15,
      image: 'assets/images/interest_type/interest_type_gaming_1.png',
    ),
    ChooserBox(
      value: InterestType.play,
      width: 300,
      height: 300,
      x: 280,
      y: 250,
      angle: 0,
      image: 'assets/images/interest_type/interest_type_gaming_2.png',
    ),
    ChooserBox(
      value: InterestType.play,
      width: 300,
      height: 300,
      x: 400,
      y: 850,
      angle: 20,
      image: 'assets/images/interest_type/interest_type_gaming_3.png',
    ),
    ChooserBox(
      value: InterestType.utility,
      width: 300,
      height: 300,
      x: 650,
      y: 750,
      angle: 0,
      image: 'assets/images/interest_type/interest_type_utility_1.png',
    ),
    ChooserBox(
      value: InterestType.utility,
      width: 250,
      height: 250,
      x: 300,
      y: 600,
      angle: 0,
      image: 'assets/images/interest_type/interest_type_utility_2.png',
    ),
    ChooserBox(
      value: InterestType.utility,
      width: 350,
      height: 300,
      x: 0,
      y: 800,
      angle: -10,
      image: 'assets/images/interest_type/interest_type_utility_3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final $s = ref.watch(intlStringsProvider);
    final selectedCount = _boxes.where((box) => box.selected).length;

    onSubmit() {
      if (selectedCount > 0) {
        final selectedBox = _boxes.firstWhere((box) => box.selected);
        final selectedInterestType = selectedBox.value;

        ref.read(questionnaireStateProvider.notifier).submitAnswer(
              interestType: selectedInterestType,
            );

        context.go('/quiz/proficiency');
      }
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.yellow,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_interest_type_title'] ?? '',
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
