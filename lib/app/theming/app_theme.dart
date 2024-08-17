import 'package:btl/app/extension/widget_state_extension.dart';
import 'package:btl/app/theming/app_colors_extension.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => _themeData(_lightColorScheme);

  static ThemeData get dark => _themeData(_darkColorScheme);
}

ThemeData _themeData(ColorsX colorScheme) {
  final textTheme = _textTheme(colorScheme.onBackground);
  return ThemeData(
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: colorScheme.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onBackground,
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        selectedBackgroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStateProperty.resolveWith((state) {
        if (state.isSelected) {
          return IconThemeData(color: colorScheme.primary);
        }
        return IconThemeData(color: colorScheme.onBackground);
      }),
      height: 65,
      labelTextStyle: WidgetStatePropertyAll(textTheme.small.copyWith(
        fontSize: 12,
        color: colorScheme.primary,
        fontWeight: FontWeight.bold,
      )),
      indicatorColor: Colors.transparent,
      backgroundColor: colorScheme.secondaryBackground,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    extensions: [
      // Use this instead of default colorScheme.
      colorScheme,
      // Use this instead of default textTheme.
      textTheme,
    ],
  );
}

final _lightColorScheme = ColorsX(
  background: AppColors.light,
  secondaryBackground: AppColors.secondaryLight,
  onBackground: AppColors.onLight,
  onBackgroundTint: AppColors.darkTint,
);

final _darkColorScheme = ColorsX(
  background: AppColors.dark,
  secondaryBackground: AppColors.secondaryDark,
  onBackground: AppColors.onDark,
  onBackgroundTint: AppColors.lightTint,
);
