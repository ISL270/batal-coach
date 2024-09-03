import 'package:btl/app/coach/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  // Blocs
  AuthBloc get authBloc => get<AuthBloc>();
  ExerciseBloc get exerciseBloc => get<ExerciseBloc>();

  // Repositories
  AuthRepository get authRepo => get<AuthRepository>();
}
