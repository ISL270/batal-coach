import 'package:btl/core/extensions/arabic_x.dart';
import 'package:btl/core/extensions/english_x.dart';

extension StringX on String {
  /// Adds definite Alif Lam if Arabic,
  ///
  /// and capitalizes first letter if Enlish.
  /// ```dart
  /// print(context.l10n.champion.capitalizedDefinite) //if en: "Champion" / if ar: "البطل"
  /// ```
  String get capitalizedDefinite => capitalized.definite;
}
