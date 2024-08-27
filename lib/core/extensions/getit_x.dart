import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/core/blocs/auth/auth_bloc.dart';
import 'package:btl/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  // Blocs
  AuthBloc get authBloc => get<AuthBloc>();
  ExerciseBloc get exerciseBloc => get<ExerciseBloc>();

  // Repositories
  AuthenticationRepository get authRepo => get<AuthenticationRepository>();
}
