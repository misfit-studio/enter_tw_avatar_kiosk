import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A widget that continuously rotates its child.
///
/// The rotation is performed by an animation controller which repeats
/// indefinitely. The duration of one full rotation is specified by the
/// `duration` parameter.
class ContinuousAnimatedRotation extends HookWidget {
  /// The widget to rotate.
  final Widget child;

  /// The duration of one full rotation.
  final Duration duration;

  /// Creates a continuously rotating widget.
  ///
  /// The [child] parameter must not be null and is the widget that will be
  /// rotated.
  ///
  /// The [duration] parameter must not be null and specifies the duration of
  /// one full rotation.
  const ContinuousAnimatedRotation({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    // Create an animation controller that repeats indefinitely.
    final animation = useAnimationController(duration: duration)..repeat();

    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        // Rotate the child by an angle that is proportional to the current
        // value of the animation.
        return Transform.rotate(
          angle: animation.value * 2 * pi,
          child: child,
        );
      },
      child: child,
    );
  }
}
