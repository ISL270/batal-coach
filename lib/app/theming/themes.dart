import 'package:btl/app/theming/app_colors_extension.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        extensions: [
          // Use this instead of default colorScheme.
          _lightColorScheme,
          // Use this instead of default textTheme.
          _textTheme,
        ],
      );

  static ThemeData get dark => ThemeData(
        extensions: [
          // Use this instead of default colorScheme.
          _darkColorScheme,
          // Use this instead of default textTheme.
          _textTheme,
        ],
      );
}

final _lightColorScheme = ColorsX(background: Colors.white);

final _darkColorScheme = ColorsX(background: Colors.grey.shade800);

final _textTheme = TextThemeX(
  small: GoogleFonts.notoSansArabic(fontSize: 12.sp),
  medium: GoogleFonts.notoSansArabic(fontSize: 16.sp),
  large: GoogleFonts.notoSansArabic(fontSize: 20.sp),
);
