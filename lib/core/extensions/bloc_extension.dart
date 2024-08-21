import 'package:btl/core/blocs/auth/auth_bloc.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Blocs on BuildContext {
  AuthBloc get authBloc => read<AuthBloc>();
  SettingsBloc get settingsBloc => read<SettingsBloc>();
}
