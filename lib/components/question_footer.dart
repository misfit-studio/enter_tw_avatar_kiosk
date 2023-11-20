import 'package:enter_bravo_kiosk/components/container_button.dart';
import 'package:enter_bravo_kiosk/state/intl_provider.dart';
import 'package:enter_bravo_kiosk/state/questionnaire_provider.dart';
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(96.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EnterContainerButton(
            trailing: const Icon(
              Icons.restart_alt,
              size: 60,
            ),
            reverse: true,
            onTap: onRestart,
          ),
          const Spacer(),
          EnterContainerButton(
            trailing: SvgPicture.asset("assets/icons/arrow.svg"),
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
      insetPadding: const EdgeInsets.all(96.0),
      titlePadding: const EdgeInsets.only(top: 48, right: 48, left: 48),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      contentPadding: const EdgeInsets.all(48.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(48)),
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
        const SizedBox(
          height: 24,
        ),
        EnterContainerButton(
          onTap: () => context.pop(false),
          child: Text($s['button_restart_cancel'] ?? ''),
        ),
      ],
    );
  }
}
