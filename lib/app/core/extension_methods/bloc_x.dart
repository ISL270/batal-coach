import 'package:btl/app/coach/features/workout_builder.dart/presentation/cubit/workout_builder_cubit.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Blocs on BuildContext {
  SettingsBloc get settingsBloc => read<SettingsBloc>();
  WorkoutBuilderCubit get wkBuilderCubit => read<WorkoutBuilderCubit>();
}

