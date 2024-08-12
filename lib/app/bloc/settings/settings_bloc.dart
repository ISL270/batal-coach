import 'package:btl/app/enum/language.dart';
import 'package:btl/app/enum/status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_bloc.g.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState.initial()) {
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsThemeChanged>(_onThemeChanged);
  }

  void _onLanguageChanged(SettingsLanguageChanged event, Emitter<SettingsState> emit) =>
      emit(state.copyWith(language: event.language));

  void _onThemeChanged(SettingsThemeChanged event, Emitter<SettingsState> emit) =>
      emit(state.copyWith(themeMode: event.themeMode));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) => SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
