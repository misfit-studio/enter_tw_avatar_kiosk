import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextCarousel extends HookConsumerWidget {
  /// Creates a TextCarousel widget.
  ///
  /// The [strings] argument must not be null and must be non-empty.
  /// The [transitionAlignment] argument defaults to [Alignment.centerLeft].
  /// The [interval] argument defaults to a duration of 5 seconds.
  /// The [transitionDuration] argument defaults to a duration of 500 milliseconds.
  const TextCarousel({
    super.key,
    required this.strings,
    this.colors,
    this.style,
    this.textAlign,
    this.transitionAlignment = Alignment.centerLeft,
    this.interval = const Duration(seconds: 5),
    this.transitionDuration = const Duration(milliseconds: 500),
  })  : assert(
          strings.length > 0,
          'Strings must have at least one element',
        ),
        assert(
          colors == null || colors.length == strings.length,
          'Colors and strings must have the same length',
        );

  /// The list of strings to display in the carousel.
  final List<String> strings;

  /// The list of colors to use for the text in the carousel.
  final List<Color>? colors;

  /// The style to use for the text in the carousel.
  final TextStyle? style;

  /// The alignment to use for the text in the carousel.
  final TextAlign? textAlign;

  /// The alignment to use for the transition in the carousel.
  final AlignmentGeometry transitionAlignment;

  /// The interval at which to change the text in the carousel.
  final Duration interval;

  /// The duration of the transition when changing the text in the carousel.
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    useEffect(() {
      final timer = Timer.periodic(interval, (timer) {
        currentIndex.value = (currentIndex.value + 1) % strings.length;
      });
      return timer.cancel;
    }, []);

    /// Returns the text style for the current text in the carousel.
    TextStyle? getTextStyle() {
      if (colors == null) {
        return style;
      } else {
        return style?.copyWith(
              color: colors![currentIndex.value],
            ) ??
            TextStyle(color: colors![currentIndex.value]);
      }
    }

    return AnimatedSwitcher(
      duration: transitionDuration,
      child: SizedBox(
        key: ValueKey(currentIndex.value),
        width: double.infinity,
        child: Text(
          strings[currentIndex.value],
          style: getTextStyle(),
          textAlign: textAlign,
        ),
      ),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: transitionAlignment,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
    );
  }
}
