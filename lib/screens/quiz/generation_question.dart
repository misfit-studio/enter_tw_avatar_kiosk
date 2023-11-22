import 'package:enter_bravo_kiosk/components/image_chooser_box.dart';
import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:enter_bravo_kiosk/utils/chooser_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerationQuestion extends ConsumerStatefulWidget {
  const GenerationQuestion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GenerationQuestionState();
}

class _GenerationQuestionState extends ConsumerState<GenerationQuestion> {
  final _boxes = <ChooserBox<int>>[
    ChooserBox(
        image: 'assets/images/generation/generation_07.png',
        value: 1984,
        width: 432,
        height: 432),
    ChooserBox(
        image: 'assets/images/generation/generation_02.png',
        value: 1965,
        width: 432,
        height: 204,
        x: 456),
    ChooserBox(
        image: 'assets/images/generation/generation_03.png',
        value: 2005,
        width: 204,
        height: 204,
        x: 456,
        y: 228),
    ChooserBox(
        image: 'assets/images/generation/generation_04.png',
        value: 1990,
        width: 204,
        height: 204,
        x: 684,
        y: 228),
    ChooserBox(
        image: 'assets/images/generation/generation_01.png',
        value: 2020,
        width: 204,
        height: 432,
        y: 456),
    ChooserBox(
        image: 'assets/images/generation/generation_06.png',
        value: 1950,
        width: 432,
        height: 432,
        x: 228,
        y: 456),
    ChooserBox(
        image: 'assets/images/generation/generation_05.png',
        value: 1990,
        width: 204,
        height: 204,
        x: 684,
        y: 456),
    ChooserBox(
        image: 'assets/images/generation/generation_08.png',
        value: 1980,
        width: 204,
        height: 432,
        x: 684,
        y: 684),
    ChooserBox(
        image: 'assets/images/generation/generation_09.png',
        value: 2020,
        width: 204,
        height: 204,
        y: 912),
    ChooserBox(
        image: 'assets/images/generation/generation_10.png',
        value: 2000,
        width: 204,
        height: 204,
        x: 228,
        y: 912),
    ChooserBox(
        image: 'assets/images/generation/generation_11.png',
        value: 1985,
        width: 204,
        height: 204,
        x: 456,
        y: 912),
  ];

  @override
  Widget build(BuildContext context) {
    final $s = ref.watch(intlStringsProvider);
    final selectedCount = _boxes.where((box) => box.selected).length;

    onSubmit() {
      if (selectedCount > 0) {
        final oldestSelectedBox = _boxes
            .where((box) => box.selected)
            .reduce((box1, box2) => box1.value < box2.value ? box1 : box2);

        Generation generation;
        if (oldestSelectedBox.value <= Generation.genX.cutoffYear) {
          generation = Generation.babyboomer;
        } else if (oldestSelectedBox.value <= Generation.genY.cutoffYear) {
          generation = Generation.genX;
        } else if (oldestSelectedBox.value <= Generation.genZ.cutoffYear) {
          generation = Generation.genY;
        } else {
          generation = Generation.genZ;
        }

        ref
            .read(questionnaireStateProvider.notifier)
            .submitAnswer(generation: generation);

        context.go('/quiz/interest_type');
      }
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.orange,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_generation_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 96.sp),
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
            onSubmit: onSubmit,
            disableSubmit: selectedCount == 0,
          ),
        ],
      ),
    );
  }
}
