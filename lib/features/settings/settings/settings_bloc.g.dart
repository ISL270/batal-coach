// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      $enumDecode(_$StatusEnumMap, json['status']),
      $enumDecode(_$LanguageEnumMap, json['language']),
      $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'language': _$LanguageEnumMap[instance.language]!,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.success: 'success',
  Status.failure: 'failure',
};

const _$LanguageEnumMap = {
  Language.arabic: 'arabic',
  Language.english: 'english',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
