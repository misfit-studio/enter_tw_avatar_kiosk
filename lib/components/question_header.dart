import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      height: 480,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: AnimatedSmoothIndicator(
              activeIndex: state.questionIndex,
              count: 7,
              effect: const ExpandingDotsEffect(
                dotWidth: 24,
                dotHeight: 24,
                spacing: 24,
                dotColor: Colors.white,
                activeDotColor: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 96,
              vertical: 48,
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
