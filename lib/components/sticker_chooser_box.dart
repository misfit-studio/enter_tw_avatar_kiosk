import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StickerChooserBox extends HookWidget {
  final String image;
  final bool selected;
  final void Function()? onTap;

  const StickerChooserBox({
    super.key,
    required this.selected,
    this.onTap,
    this.image = 'assets/images/interest_type_gaming_2.png',
  });

  @override
  Widget build(BuildContext context) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 150),
    )..repeat(reverse: true);

    final hovering = useState(false);
    return InkWell(
      onTap: onTap,
      onHover: (value) => hovering.value = value,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: selected
            ? 1.2
            : hovering.value
                ? 1.1
                : 1,
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: selected ? animation.value * 0.05 : 0,
                child: Image.asset(image),
              );
            }),
      ),
    );
  }
}
