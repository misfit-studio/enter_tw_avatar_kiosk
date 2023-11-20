import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ContinuousAnimatedRotation extends HookWidget {
  final Widget child;
  final Duration duration;

  const ContinuousAnimatedRotation({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(duration: duration)..repeat();
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Transform.rotate(
          angle: animation.value * 2 * pi,
          child: child,
        );
      },
      child: child,
    );
  }
}
