import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/coach/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/app/core/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  // Blocs
  AuthBloc get authBloc => get<AuthBloc>();
  ExerciseBloc get exerciseBloc => get<ExerciseBloc>();

  // Repositories
  AuthenticationRepository get authRepo => get<AuthenticationRepository>();
}
