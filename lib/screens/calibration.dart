import 'dart:async';

import 'package:enter_bravo_kiosk/components/text_carousel.dart';
import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalibrationScreen extends HookConsumerWidget {
  final String? from;

  const CalibrationScreen({
    super.key,
    this.from,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calibrationCompleted = useState(false);
    final animation = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    useEffect(() {
      final subscription = ref
          .read(pointerButtonStateNotifierProvider.notifier)
          .eventStream
          .listen((event) {
        if (!calibrationCompleted.value) {
          switch (event) {
            case PointerButtonEvent.pressed:
              animation.reset();
              animation.forward();
              ref
                  .read(pointerDeviceStateNotifierProvider.notifier)
                  .startCalibration();
              break;
            case PointerButtonEvent.released:
              animation.reverse();
              break;
          }
        } else if (event == PointerButtonEvent.released) {
          context.go(from ?? '/language');
        }
      });
      return subscription.cancel;
    }, []);

    useEffect(() {
      void statusListener(AnimationStatus status) async {
        if (status == AnimationStatus.completed) {
          await ref
              .read(pointerDeviceStateNotifierProvider.notifier)
              .commitCalibration();

          calibrationCompleted.value = true;
          Timer(const Duration(seconds: 5), () {
            calibrationCompleted.value = false;
          });
        }
      }

      animation.addStatusListener(statusListener);
      return () => animation.removeStatusListener(statusListener);
    }, []);

    final tween = Tween<double>(
      begin: 1,
      end: 0.01,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: calibrationCompleted.value ? 0 : 1,
              child: Container(
                width: 48.sp,
                height: 48.sp,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
            ),
          ),
          if (!calibrationCompleted.value)
            Center(
              child: UnconstrainedBox(
                clipBehavior: Clip.hardEdge,
                child: ScaleTransition(
                  scale: tween.animate(animation),
                  child: Container(
                    width: 2400.sp,
                    height: 2400.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1920.sp),
                      border: Border.all(
                        color: Colors.white,
                        width: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!calibrationCompleted.value)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: GestureDetector(
                onDoubleTap: () {
                  context.go(from ?? '/language');
                },
                child: Padding(
                  padding: EdgeInsets.all(96.sp),
                  child: TextCarousel(
                    strings: const [
                      "Zeige mit dem Gerät auf den Punkt und halte den Knopf gedrückt.",
                      "Point the device at the dot and hold the button.",
                      "Pointe l'appareil vers le point et maintiens le bouton enfoncé.",
                    ],
                    transitionAlignment: Alignment.bottomLeft,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          if (calibrationCompleted.value)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.all(96.sp),
                child: TextCarousel(
                  strings: const [
                    "Lasse den Knopf los, um fortzufahren.",
                    "Release the button to continue.",
                    "Relâche le bouton pour continuer.",
                  ],
                  transitionAlignment: Alignment.bottomLeft,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
