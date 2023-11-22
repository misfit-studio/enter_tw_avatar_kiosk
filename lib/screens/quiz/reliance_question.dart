import 'package:enter_bravo_kiosk/components/question_footer.dart';
import 'package:enter_bravo_kiosk/components/question_header.dart';
import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelianceQuestion extends HookConsumerWidget {
  const RelianceQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);

    final sliderValue = useState<double>(0);

    onSubmit() {
      final reliance = Reliance.values[(sliderValue.value * 2).floor()];

      ref
          .read(questionnaireStateProvider.notifier)
          .submitAnswer(reliance: reliance);

      context.go('/quiz/presentation');
    }

    return Scaffold(
      backgroundColor: EnterThemeColors.purple,
      body: Column(
        children: [
          QuestionHeader(
            questionText: $s['question_reliance_title'] ?? '',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(96.sp),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (sliderValue.value >= 1 / 6)
                    const Positioned(
                      top: 0,
                      left: 0,
                      child: WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_01.png',
                      ),
                    ),
                  if (sliderValue.value >= 2 / 6)
                    Positioned(
                      top: 350.h,
                      left: 300.w,
                      child: const WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_02.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                  if (sliderValue.value >= 3 / 6)
                    Positioned(
                      top: 400.h,
                      left: 0,
                      child: const WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_03.png',
                      ),
                    ),
                  if (sliderValue.value >= 4 / 6)
                    Positioned(
                      top: -100.h,
                      left: 360.w,
                      child: const WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_04.png',
                      ),
                    ),
                  if (sliderValue.value >= 5 / 6)
                    Positioned(
                      top: 0,
                      left: 320.w,
                      child: const WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_05.png',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  if (sliderValue.value >= 1)
                    Positioned(
                      top: 50.h,
                      left: 50.w,
                      child: const WiggleNoiseDevice(
                        image: 'assets/images/reliance/reliance_06.png',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildSlider(context, sliderValue),
                  ),
                ],
              ),
            ),
          ),
          QuestionFooter(
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }

  SliderTheme _buildSlider(
      BuildContext context, ValueNotifier<double> sliderValue) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: Theme.of(context).colorScheme.onBackground,
        inactiveTrackColor: Theme.of(context).colorScheme.onBackground,
        trackHeight: 18.sp,
        thumbColor: Colors.white,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 36.sp,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Icon(
              Icons.remove,
              size: 72.sp,
            ),
          ),
          Expanded(
            child: Slider(
              value: sliderValue.value,
              divisions: 6,
              onChanged: (value) => sliderValue.value = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Icon(
              Icons.add,
              size: 72.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class WiggleNoiseDevice extends HookWidget {
  final String image;
  final double width;
  final double height;

  const WiggleNoiseDevice({
    super.key,
    this.image = 'assets/images/phone_placeholder.png',
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 100),
    )..repeat(reverse: true);

    final splashAnimation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 1 - splashAnimation.value,
                child: Transform.scale(
                  scale: splashAnimation.value,
                  child: Container(
                    width: width * 2.w,
                    height: width * 2.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 4.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: animation.value * 0.1,
                child: Image.asset(
                  image,
                  width: width.w,
                ),
              ),
            ],
          );
        });
  }
}
