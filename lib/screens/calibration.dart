import 'package:enter_bravo_kiosk/components/text_carousel.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:enter_bravo_kiosk/state/serial_provider.dart';
import 'package:enter_bravo_kiosk/utils/serial_protocol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalibrationScreen extends HookConsumerWidget {
  const CalibrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);
    final pointerState = ref.watch(pointerDeviceStateNotifierProvider);
    final protocol = ref.watch(serialProtocolProvider);

    final animation = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    bool lastBtnAPressed = false;

    useEffect(() {
      final subscription = protocol.eventStream.listen((event) {
        if (event is PointerDeviceData &&
            event.btnAPressed != lastBtnAPressed) {
          lastBtnAPressed = event.btnAPressed;
          if (event.btnAPressed) {
            animation.reset();
            animation.forward();
            ref
                .read(pointerDeviceStateNotifierProvider.notifier)
                .startCalibration();
          } else if (event.calibrationStatus == CalibrationStatus.calibrated) {
            // Navigator.of(context)
            //     .pushReplacementNamed('/questionnaire/generation');
          } else if (pointerState == PointerState.calibrating) {
            animation.reverse();
          }
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

          if (context.mounted) {
            Navigator.of(context).popAndPushNamed('/questionnaire/generation');
          }
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
      body: GestureDetector(
        onDoubleTap: () {
          context.go('/language');
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
            ),
            Center(
              child: UnconstrainedBox(
                clipBehavior: Clip.hardEdge,
                child: ScaleTransition(
                  scale: tween.animate(animation),
                  child: Container(
                    width: 2400,
                    height: 2400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1920),
                      border: Border.all(
                        color: Colors.white,
                        width: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(96.0),
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
          ],
        ),
      ),
    );
  }
}
