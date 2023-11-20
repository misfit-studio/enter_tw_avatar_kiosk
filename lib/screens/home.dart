import 'package:enter_bravo_kiosk/components/text_carousel.dart';
import 'package:enter_bravo_kiosk/state/pointer_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(pointerDeviceStateNotifierProvider, (prev, next) {
      if (next == PointerState.calibrating) {
        Navigator.pushNamed(context, '/calibration');
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          ref.read(questionnaireStateProvider.notifier).reset();
          context.go('/calibration');
        },
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(96.0),
                child: TextCarousel(
                  strings: const [
                    "Wie stehst du zu mir?",
                    "What's our relationship?",
                    "Sommes-nous amis?"
                  ],
                  colors: const [
                    EnterThemeColors.orange,
                    EnterThemeColors.green,
                    EnterThemeColors.blue,
                  ],
                  style: Theme.of(context).textTheme.headlineLarge,
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
                    "Finde deinen Techniktyp!\nNimm das Gerät in die Hand, um zu beginnen.",
                    "Find your tech personality!\nPick up the device to begin.",
                    "Trouve ton type de technologie!\nPrenez l'appareil pour commencer."
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
