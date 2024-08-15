import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors_extension.tailor.dart';

// We should use [ColorScheme] only if our design exactly follows the Material specifications.
// Since this is not the case, its better to define our own color scheme using [ThemeExtension].
// 'X' in class name stands for 'Extension'.
/// App Colors based our design system.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class ColorsX extends ThemeExtension<ColorsX> with _$ColorsXTailorMixin {
  @override
  final Color primary = const Color(0xFFFF3232);
  @override
  final Color onPrimary = const Color(0xFFFFFFFF);
  @override
  final Color background;
  @override
  final Color secondaryBackground;
  @override
  final Color onBackground;

  ColorsX({
    required this.background,
    required this.secondaryBackground,
    required this.onBackground,
  });
}
