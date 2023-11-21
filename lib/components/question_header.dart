import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionHeader extends ConsumerWidget {
  final String questionText;

  const QuestionHeader({
    super.key,
    required this.questionText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionnaireStateProvider);

    return SizedBox(
      height: 480.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(48.sp),
            child: AnimatedSmoothIndicator(
              activeIndex: state.questionIndex,
              count: 7,
              effect: ExpandingDotsEffect(
                dotWidth: 24.sp,
                dotHeight: 24.sp,
                spacing: 24.sp,
                dotColor: Colors.white,
                activeDotColor: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 96.sp,
              vertical: 48.sp,
            ),
            child: Text(
              questionText,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
