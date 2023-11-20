import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setLanguage(Language language) {
      ref.read(selectedLanguageProvider.notifier).setLanguage(language);
      context.go('/quiz');
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(264.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EnterContainerButton(
              trailing: SvgPicture.asset("assets/icons/arrow.svg"),
              onTap: () => setLanguage(Language.de),
              child: const Text("Deutsch"),
            ),
            const SizedBox(height: 48),
            EnterContainerButton(
              trailing: SvgPicture.asset("assets/icons/arrow.svg"),
              onTap: () => setLanguage(Language.en),
              child: const Text("English"),
            ),
            const SizedBox(height: 48),
            EnterContainerButton(
              trailing: SvgPicture.asset("assets/icons/arrow.svg"),
              onTap: () => setLanguage(Language.fr),
              child: const Text("Français"),
            ),
          ],
        ),
      ),
    );
  }
}
