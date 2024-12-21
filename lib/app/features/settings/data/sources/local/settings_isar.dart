import 'package:btl/app/core/isar/cache_model.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/features/settings/domain/settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'settings_isar.g.dart';

@collection
final class SettingsIsar extends CacheModel<Settings> {
  @override
  String id = '';
  @override
  Id cacheID = Isar.autoIncrement;
  @Enumerated(EnumType.name)
  final Language language;
  @Enumerated(EnumType.name)
  final ThemeMode themeMode;

  SettingsIsar({
    required this.language,
    required this.themeMode,
  });

  factory SettingsIsar.fromDomain(Settings domain) => SettingsIsar(
        language: domain.language,
        themeMode: domain.themeMode,
      );

  @override
  Settings toDomain() => Settings(
        language: language,
        themeMode: themeMode,
      );
}
