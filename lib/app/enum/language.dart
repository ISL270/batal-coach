import 'dart:ui';

enum Language {
  arabic('ar', Locale('ar'), 'العربية'),
  english('en', Locale('en'), 'English');

  final Locale locale;
  final String code;
  final String name;

  const Language(this.code, this.locale, this.name);
}
