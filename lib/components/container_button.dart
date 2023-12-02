import 'package:enter_bravo_kiosk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.expanded = false,
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
  // Whether the button should be expanded to fill the available space.
  final bool expanded;
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
        horizontal: child != null ? 36.sp : 8.sp,
        vertical: 8.sp,
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
                padding: EdgeInsets.only(right: trailing != null ? 24.sp : 0),
                child: child!,
              ),
            if (trailing != null) ...[
              if (expanded) const Spacer(),
              _buildTrailing(isHovering),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing(bool isHovering) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
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
      top: isHovering ? 0 : 150.sp,
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
      onLongPress: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(96.sp)),
      child: child,
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: onTap == null ? backgroundColor.withOpacity(0.5) : backgroundColor,
      borderRadius: BorderRadius.circular(96.sp),
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: borderColor != null ? 5.sp : 0,
      ),
    );
  }
}
