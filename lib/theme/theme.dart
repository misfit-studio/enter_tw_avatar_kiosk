import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterThemeColors {
  static const red = Color(0xFFFF3333);
  static const orange = Color(0xFFFFA347);
  static const green = Color(0xFF9ADE52);
  static const yellow = Color(0xFFFFE173);
  static const turquoise = Color(0xFF35F0F0);
  static const blue = Color(0xFF4DA6FF);
  static const purple = Color(0xFFB16EF5);
  static const pink = Color(0xFFE85DE8);
}

final baseTheme = ThemeData(
  fontFamily: 'ABC Diatype Rounded',
  colorSchemeSeed: EnterThemeColors.blue,
);

final enterTextTheme = baseTheme.textTheme.copyWith(
  headlineLarge: baseTheme.textTheme.headlineLarge!.copyWith(
    fontSize: 148.sp,
    height: 1.18,
    fontWeight: FontWeight.w700,
  ),
  headlineMedium: baseTheme.textTheme.headlineMedium!.copyWith(
    fontSize: 92.sp,
    height: 1.05,
    fontWeight: FontWeight.w700,
  ),
  titleLarge: baseTheme.textTheme.titleLarge!.copyWith(
    fontSize: 92.sp,
    height: 1.05,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: baseTheme.textTheme.titleMedium!.copyWith(
    fontSize: 64.sp,
    height: 1.05,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: baseTheme.textTheme.titleSmall!.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
  ),
  labelLarge: baseTheme.textTheme.labelLarge!.copyWith(
    fontSize: 64.sp,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: baseTheme.textTheme.bodyLarge!.copyWith(
    fontSize: 64.sp,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: baseTheme.textTheme.bodyMedium!.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: baseTheme.textTheme.bodySmall!.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
  ),
);

final enterTheme = baseTheme.copyWith(
  textTheme: enterTextTheme,
);
