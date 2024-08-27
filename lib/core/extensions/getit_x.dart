import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/features/exercise/data/repositories/exercise_repository.dart';
import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  ExerciseRepository get exerciseRepo => get<ExerciseRepository>();
  AuthenticationRepository get authRepo => get<AuthenticationRepository>();
}
