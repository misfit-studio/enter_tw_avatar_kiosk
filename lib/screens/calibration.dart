import 'dart:async';

import 'package:enter_bravo_kiosk/components/text_carousel.dart';
import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:enter_bravo_kiosk/state/serial_provider.dart';
import 'package:enter_bravo_kiosk/utils/serial_protocol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum CalibrationScreenState {
  waiting,
  inProgress,
  loading,
  completed,
}

class CalibrationScreen extends HookConsumerWidget {
  final String? from;

  const CalibrationScreen({
    super.key,
    this.from,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState<CalibrationScreenState>(
      CalibrationScreenState.waiting,
    );

    final animation = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    // Tween for Circle animation
    final tween = Tween<double>(
      begin: 1,
      end: 0.01,
    );

    final timeout = useState<Timer?>(null);

    startCalibrationAnimation() {
      state.value = CalibrationScreenState.inProgress;

      animation.reset();
      animation.forward();

      ref.read(pointerDeviceStateNotifierProvider.notifier).startCalibration();
    }

    cancelCalibrationAnimation() {
      state.value = CalibrationScreenState.waiting;
      animation.reverse();
    }

    commitCalibration() async {
      state.value = CalibrationScreenState.loading;

      await ref
          .read(pointerDeviceStateNotifierProvider.notifier)
          .commitCalibration();

      state.value = CalibrationScreenState.completed;

      // If anything goes wrong, go back to waiting state after some seconds
      timeout.value?.cancel();
      timeout.value = Timer(const Duration(seconds: 5), () {
        state.value = CalibrationScreenState.waiting;
      });
    }

    exit() {
      context.go(from ?? '/language');
    }

    // Watch button state
    final protocol = ref.watch(serialProtocolProvider);
    useEffect(() {
      final subscription = protocol.eventStream.listen((event) {
        if (event is! PointerDeviceData) return;
        switch (state.value) {
          case CalibrationScreenState.waiting:
            // Start when button is pressed
            if (event.btnAPressed) startCalibrationAnimation();
            break;
          case CalibrationScreenState.inProgress:
            // Cancel when button is released before animation finishes
            if (!event.btnAPressed) cancelCalibrationAnimation();
            break;
          case CalibrationScreenState.completed:
            // exit as soon as button is released
            if (!event.btnAPressed) exit();
            break;
          default:
            break;
        }
      });
      return subscription.cancel;
    }, []);

    // Watch animation state
    useEffect(() {
      void animationListener() {
        // Commit calibration when animation is almost finished
        if (animation.value > 0.8 &&
            state.value == CalibrationScreenState.inProgress) {
          commitCalibration();
        }
      }

      animation.addListener(animationListener);
      return () => animation.removeListener(animationListener);
    }, []);

    buildCenterPoint() {
      return Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: state.value == CalibrationScreenState.completed ? 0 : 1,
          child: Container(
            width: 48.sp,
            height: 48.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48),
            ),
          ),
        ),
      );
    }

    buildLoadingIndicator() {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    buildCircleAnimation() {
      return Center(
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
      );
    }

    buildInstructionText() {
      return Positioned(
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
      );
    }

    buildExitText() {
      return Positioned(
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
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          buildCenterPoint(),
          if (state.value == CalibrationScreenState.loading)
            buildLoadingIndicator(),
          if (state.value != CalibrationScreenState.completed)
            buildCircleAnimation(),
          if (state.value != CalibrationScreenState.completed)
            buildInstructionText()
          else
            buildExitText(),
        ],
      ),
    );
  }
}
