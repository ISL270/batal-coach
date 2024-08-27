import 'package:btl/core/generic_exception.dart';
import 'package:btl/features/exercise/data/models/exercise_rm.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<Either<NetworkException, Iterable<ExerciseRM>>> getExercises({required String searchTerm});
}
