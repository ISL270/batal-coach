import 'package:btl/app/theming/app_colors_extension.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => _themeData(_lightColorScheme);

  static ThemeData get dark => _themeData(_darkColorScheme);
}

ThemeData _themeData(ColorsX colorScheme) => ThemeData(
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: colorScheme.primary,
          selectedForegroundColor: colorScheme.onPrimary,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        indicatorColor: colorScheme.primary,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      extensions: [
        // Use this instead of default colorScheme.
        colorScheme,
        // Use this instead of default textTheme.
        _textTheme(colorScheme.onBackground),
      ],
    );

final _lightColorScheme = ColorsX(
  background: Colors.white,
  onBackground: Colors.grey.shade900,
);

final _darkColorScheme = ColorsX(
  background: Colors.grey.shade900,
  onBackground: Colors.white,
);

TextThemeX _textTheme(Color color) => TextThemeX(
      small: GoogleFonts.notoSansArabic(fontSize: 14.sp, color: color),
      medium: GoogleFonts.notoSansArabic(fontSize: 16.sp, color: color),
      large: GoogleFonts.notoSansArabic(fontSize: 18.sp, color: color),
    );
