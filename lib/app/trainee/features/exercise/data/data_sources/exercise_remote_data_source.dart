import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/trainee/features/exercise/data/models/exercise_rm.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<Either<NetworkException, Iterable<ExerciseRM>>> getExercises({
    required String searchTerm,
    required int pageSize,
    required int page,
  });
}
