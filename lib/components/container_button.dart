import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterContainerButton extends HookConsumerWidget {
  const EnterContainerButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.foregroundColor,
    this.highlightColor = EnterThemeColors.purple,
    this.borderColor,
    this.trailing,
    this.reverse = false,
    this.child,
    this.onTap,
  });

  final Color backgroundColor;
  final Color? foregroundColor;
  final Color highlightColor;
  final Color? borderColor;
  final Widget? trailing;
  final Widget? child;
  final bool reverse;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovering = useState(false);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color:
            onTap == null ? backgroundColor.withOpacity(0.5) : backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(96.0)),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderColor != null ? 5.0 : 0,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onHover: (value) => isHovering.value = value,
        onTapDown: (_) => isHovering.value = true,
        onTapCancel: () => isHovering.value = false,
        onTapUp: (_) => isHovering.value = false,
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(96.0)),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: isHovering.value ? 0 : 150,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: highlightColor.withOpacity(0.25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: child != null ? 36.0 : 8.0,
                vertical: 8.0,
              ),
              child: DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (child != null)
                      Padding(
                        padding:
                            EdgeInsets.only(right: trailing != null ? 24.0 : 0),
                        child: child!,
                      ),
                    if (trailing != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: (isHovering.value ? 0.125 : 0) *
                              (reverse ? -1 : 1),
                          child: trailing,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
