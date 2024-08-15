import 'dart:ui';

enum Language {
  arabic('ar', Locale('ar'), 'العربية'),
  english('en', Locale('en'), 'English');

  final Locale locale;
  final String code;
  final String name;

  const Language(this.code, this.locale, this.name);
}

extension LanguageX on Language {
  bool get isArabic => this == Language.arabic;
  bool get isEnglish => this == Language.english;
}
