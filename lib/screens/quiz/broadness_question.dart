import 'package:enter_bravo_kiosk/components/image_chooser_box.dart';
import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:enter_bravo_kiosk/utils/chooser_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BroadnessQuestion extends StatefulHookConsumerWidget {
  const BroadnessQuestion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BroadnessQuestionState();
}

class _BroadnessQuestionState extends ConsumerState<BroadnessQuestion> {
  final _boxes = <ChooserBox>[
    ChooserBox(
      value: null,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 312,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 624,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      y: 312,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 312,
      y: 312,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 624,
      y: 312,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      y: 624,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 312,
      y: 624,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
    ChooserBox(
      value: null,
      x: 624,
      y: 624,
      width: 264,
      height: 264,
      image: 'assets/images/broadness_01.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final $s = ref.watch(intlStringsProvider);
    final selectedCount = _boxes.where((box) => box.selected).length;

    onSubmit() {
      Broadness selectedBroadness;
      if (selectedCount <= 2) {
        selectedBroadness = Broadness.limited;
      } else if (selectedCount <= 4) {
        selectedBroadness = Broadness.diverse;
      } else {
        selectedBroadness = Broadness.broad;
      }

      ref
          .read(questionnaireStateProvider.notifier)
          .submitAnswer(broadness: selectedBroadness);

      context.go('/quiz/reliance');
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.blue,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_broadness_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(96.sp),
              child: Stack(
                children: List.generate(_boxes.length, (index) {
                  final box = _boxes[index];
                  return Positioned(
                    left: box.x.sp,
                    top: box.y.sp,
                    width: box.width.w,
                    height: box.height.h,
                    child: ImageChooserBox(
                      selected: box.selected,
                      imagePath: box.image,
                      onTap: () {
                        box.selected = !box.selected;
                        setState(() {});
                      },
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
