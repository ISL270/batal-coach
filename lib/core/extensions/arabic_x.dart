import 'package:btl/core/extensions/validator.dart';

extension ArabicX on String {
  /// تضيف "ال" لاول الكلمة
  String get definite => hasArabicChars ? 'ال$this' : this;
}
