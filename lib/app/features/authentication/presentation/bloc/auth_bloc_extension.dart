import 'package:btl/app/coach/features/exercise/presentation/exercises_screen.dart';
import 'package:btl/app/features/authentication/domain/models/user_x.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';

extension AuthBlocX on AuthBloc {
  String get homeNamedRoute {
    if (state.user?.isCoach ?? true) {
      return WorkoutScreen.name;
    }
    return throw UnimplementedError();
  }
}
