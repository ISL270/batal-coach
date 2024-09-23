import 'package:btl/app/core/extensions/arabic_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';

extension StringX on String {
  /// Adds definite Alif Lam if Arabic,
  ///
  /// and capitalizes first letter if Enlish.
  /// ```dart
  /// print(context.l10n.champion.capitalizedDefinite) //if en: "Champion" / if ar: "البطل"
  /// ```
  String get capitalizedDefinite => capitalized.definite;

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings
  int get fastHash {
    // ignore: avoid_js_rounded_ints
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < length) {
      final codeUnit = codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
