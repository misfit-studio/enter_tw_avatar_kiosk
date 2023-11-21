import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.all(264.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EnterContainerButton(
              expanded: true,
              trailing: SvgPicture.asset(
                "assets/icons/arrow.svg",
                width: 48.sp,
              ),
              onTap: () => setLanguage(Language.de),
              child: Text(
                "Deutsch",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 84.sp),
              ),
            ),
            SizedBox(height: 48.sp),
            EnterContainerButton(
              expanded: true,
              trailing: SvgPicture.asset(
                "assets/icons/arrow.svg",
                width: 48.sp,
              ),
              onTap: () => setLanguage(Language.en),
              child: Text(
                "English",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 84.sp),
              ),
            ),
            SizedBox(height: 48.sp),
            EnterContainerButton(
              expanded: true,
              trailing: SvgPicture.asset(
                "assets/icons/arrow.svg",
                width: 48.sp,
              ),
              onTap: () => setLanguage(Language.fr),
              child: Text(
                "Français",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 84.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
