import 'package:btl/app/core/blocs/auth/auth_bloc.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Blocs on BuildContext {
  AuthBloc get authBloc => read<AuthBloc>();
  SettingsBloc get settingsBloc => read<SettingsBloc>();
}
