import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A custom button widget for the Enter Bravo Kiosk application.
/// This button can be customized with different colors, a trailing widget,
/// and a child widget. It also has a hover effect.
class EnterContainerButton extends HookConsumerWidget {
  // Constructor for the EnterContainerButton class.
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

  // The background color of the button.
  final Color backgroundColor;
  // The foreground color of the button.
  final Color? foregroundColor;
  // The color of the button when it is highlighted.
  final Color highlightColor;
  // The color of the button's border.
  final Color? borderColor;
  // A widget to display after the button's child.
  final Widget? trailing;
  // The main widget displayed in the button.
  final Widget? child;
  // Whether the trailing widget's rotation effect should be reversed.
  final bool reverse;
  // The function to call when the button is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // A state variable to track whether the button is being hovered over.
    final isHovering = useState(false);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: _buildBoxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: _buildInkWell(
        context,
        onHoverStateChanged: (value) => isHovering.value = value,
        child: Stack(
          children: [
            _buildHighlight(isHovering.value),
            _buildContent(context, isHovering.value),
          ],
        ),
      ),
    );
  }

  Padding _buildContent(BuildContext context, bool isHovering) {
    return Padding(
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
                padding: EdgeInsets.only(right: trailing != null ? 24.0 : 0),
                child: child!,
              ),
            if (trailing != null) _buildTrailing(isHovering),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing(bool isHovering) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 200),
        turns: (isHovering ? 0.125 : 0) * (reverse ? -1 : 1),
        child: trailing,
      ),
    );
  }

  Widget _buildHighlight(bool isHovering) {
    return AnimatedPositioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: isHovering ? 0 : 150,
      duration: const Duration(milliseconds: 200),
      child: Container(
        color: highlightColor.withOpacity(0.25),
      ),
    );
  }

  Widget _buildInkWell(
    BuildContext context, {
    required void Function(bool value) onHoverStateChanged,
    Widget? child,
  }) {
    return InkWell(
      onHover: (value) => onHoverStateChanged(value),
      onTapDown: (_) => onHoverStateChanged(true),
      onTapCancel: () => onHoverStateChanged(false),
      onTapUp: (_) => onHoverStateChanged(false),
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(96.0)),
      child: child,
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: onTap == null ? backgroundColor.withOpacity(0.5) : backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(96.0)),
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: borderColor != null ? 5.0 : 0,
      ),
    );
  }
}
