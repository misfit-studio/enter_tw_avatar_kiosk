import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionFooter extends ConsumerWidget {
  const QuestionFooter({
    super.key,
    this.onSubmit,
    this.disableSubmit = false,
  });

  final bool disableSubmit;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);
    onRestart() async {
      final willRestart = await showDialog(
        context: context,
        builder: (_) => const RestartDialog(),
      );

      if (willRestart == true && context.mounted) {
        ref.read(questionnaireStateProvider.notifier).reset();
        context.go('/');
      }
    }

    return Padding(
      padding: EdgeInsets.all(96.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EnterContainerButton(
            trailing: Icon(
              Icons.restart_alt,
              size: 60.sp,
            ),
            reverse: true,
            onTap: onRestart,
          ),
          const Spacer(),
          EnterContainerButton(
            trailing: SvgPicture.asset(
              "assets/icons/arrow.svg",
              width: 36.sp,
            ),
            onTap: disableSubmit ? null : onSubmit,
            child: Text($s['button_next'] ?? ''),
          ),
        ],
      ),
    );
  }
}

class RestartDialog extends ConsumerWidget {
  const RestartDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $s = ref.watch(intlStringsProvider);

    return AlertDialog(
      insetPadding: EdgeInsets.all(96.sp),
      titlePadding: EdgeInsets.only(top: 48.sp, right: 48.sp, left: 48.sp),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      contentPadding: EdgeInsets.all(48.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48.sp),
      ),
      elevation: 0,
      title: Text(
        $s['dialog_restart_title'] ?? '',
      ),
      content: Text($s['dialog_restart_description'] ?? ''),
      actions: [
        EnterContainerButton(
          onTap: () => context.pop(true),
          foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          highlightColor: Theme.of(context).colorScheme.error,
          child: Text($s['button_restart_yes'] ?? ''),
        ),
        SizedBox(
          height: 24.sp,
        ),
        EnterContainerButton(
          onTap: () => context.pop(false),
          child: Text($s['button_restart_cancel'] ?? ''),
        ),
      ],
    );
  }
}
