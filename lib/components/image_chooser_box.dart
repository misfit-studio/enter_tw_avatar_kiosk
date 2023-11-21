import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageChooserBox extends HookWidget {
  final void Function()? onTap;
  final bool selected;
  final String imagePath;

  const ImageChooserBox({
    super.key,
    this.imagePath = 'assets/images/generation_01.jpg',
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final hovering = useState(false);

    return Material(
      elevation: (hovering.value || selected) ? 12 : 0,
      borderRadius: BorderRadius.circular(40.sp),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onHover: (state) => hovering.value = state,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.sp),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: selected ? 8.sp : 0,
            ),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
