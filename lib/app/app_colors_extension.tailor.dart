// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'app_colors_extension.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ColorsXTailorMixin on ThemeExtension<ColorsX> {
  Color get primary;
  Color get background;

  @override
  ColorsX copyWith({
    Color? primary,
    Color? background,
  }) {
    return ColorsX(
      primary: primary ?? this.primary,
      background: background ?? this.background,
    );
  }

  @override
  ColorsX lerp(covariant ThemeExtension<ColorsX>? other, double t) {
    if (other is! ColorsX) return this as ColorsX;
    return ColorsX(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorsX &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality()
                .equals(background, other.background));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(background),
    );
  }
}

extension ColorsXBuildContext on BuildContext {
  ColorsX get colorsX => Theme.of(this).extension<ColorsX>()!;
}
