part of 'settings_bloc.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  final Status status;
  final Language language;
  final ThemeMode themeMode;

  const SettingsState(
    this.status,
    this.language,
    this.themeMode,
  );

  const SettingsState.initial()
      : status = Status.initial,
        language = Language.arabic,
        themeMode = ThemeMode.light;

  @override
  List<Object> get props => [
        status,
        language,
        themeMode,
      ];

  SettingsState copyWith({
    Status? status,
    Language? language,
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      status ?? this.status,
      language ?? this.language,
      themeMode ?? this.themeMode,
    );
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);
}
