import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WiggleNoiseDevice extends HookWidget {
  final String image;
  final double width;
  final double height;
  final bool ripples;

  const WiggleNoiseDevice({
    super.key,
    this.image = 'assets/images/phone_placeholder.png',
    this.width = 200,
    this.height = 200,
    this.ripples = true,
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
              if (ripples)
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
