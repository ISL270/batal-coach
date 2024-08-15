// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'app_colors_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ColorsXTailorMixin on ThemeExtension<ColorsX> {
  Color get primary;
  Color get onPrimary;
  Color get background;
  Color get secondaryBackground;
  Color get onBackground;

  @override
  ColorsX copyWith({
    Color? primary,
    Color? onPrimary,
    Color? background,
    Color? secondaryBackground,
    Color? onBackground,
  }) {
    return ColorsX(
      background: background ?? this.background,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  ColorsX lerp(covariant ThemeExtension<ColorsX>? other, double t) {
    if (other is! ColorsX) return this as ColorsX;
    return ColorsX(
      background: Color.lerp(background, other.background, t)!,
      secondaryBackground:
          Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorsX &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality().equals(onPrimary, other.onPrimary) &&
            const DeepCollectionEquality()
                .equals(background, other.background) &&
            const DeepCollectionEquality()
                .equals(secondaryBackground, other.secondaryBackground) &&
            const DeepCollectionEquality()
                .equals(onBackground, other.onBackground));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(onPrimary),
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(secondaryBackground),
      const DeepCollectionEquality().hash(onBackground),
    );
  }
}

extension ColorsXBuildContext on BuildContext {
  ColorsX get colorsX => Theme.of(this).extension<ColorsX>()!;
}
