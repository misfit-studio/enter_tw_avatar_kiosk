import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/components/wiggle_noise_device.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresentationQuestion extends HookConsumerWidget {
  const PresentationQuestion({super.key});

  static const phonePositions = [
    Offset(390, 60),
    Offset(170, 350),
    Offset(80, 640),
    Offset(290, 650),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);

    final selectedPresentation = useState<Presenation?>(null);

    onSubmit() {
      if (selectedPresentation.value == null) return;
      ref
          .read(questionnaireStateProvider.notifier)
          .submitAnswer(presentation: selectedPresentation.value!);

      context.go('/result');
    }

    final phonePosition = selectedPresentation.value != null
        ? phonePositions[selectedPresentation.value!.index]
        : const Offset(700, -50);

    return Scaffold(
      backgroundColor: EnterThemeColors.pink,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_presentation_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(96.sp),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset('assets/images/presentation_bg.svg'),
                  AnimatedPositioned(
                    top: phonePosition.dy,
                    left: phonePosition.dx,
                    duration: const Duration(milliseconds: 500),
                    child: WiggleNoiseDevice(
                      image: 'assets/images/reliance/reliance_01.png',
                      ripples: false,
                      width: 100.sp,
                      height: 100.sp,
                    ),
                  ),
                  Positioned(
                    top: 50.sp,
                    width: 500.sp,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedPresentation.value = Presenation.none;
                      },
                      borderColor:
                          selectedPresentation.value == Presenation.none
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_presentation_label_off'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 400.sp,
                    right: 0,
                    width: 500.sp,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedPresentation.value = Presenation.low;
                      },
                      borderColor: selectedPresentation.value == Presenation.low
                          ? Colors.black
                          : null,
                      child: Text(
                        $s['question_presentation_label_otherroom'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 715.sp,
                    left: 170.sp,
                    width: 320.sp,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedPresentation.value = Presenation.high;
                      },
                      borderColor:
                          selectedPresentation.value == Presenation.high
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_presentation_label_withme'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 900.sp,
                    left: 0.sp,
                    width: 540.sp,
                    child: EnterContainerButton(
                      onTap: () {
                        selectedPresentation.value = Presenation.moderate;
                      },
                      borderColor:
                          selectedPresentation.value == Presenation.moderate
                              ? Colors.black
                              : null,
                      child: Text(
                        $s['question_presentation_label_sameroom'] ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          QuestionFooter(
            disableSubmit: selectedPresentation.value == null,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}
