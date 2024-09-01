import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/trainee/features/exercise/data/data_sources/exercise_remote_data_source.dart';
import 'package:btl/app/trainee/features/exercise/data/models/exercise_rm.dart';
import 'package:btl/app/trainee/features/exercise/domain/models/exercise.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
class ExerciseRepository {
  final pageSize = 10;
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepository(this._remoteDataSource);

  Future<Either<GenericException, Iterable<Exercise>>> getExercises({
    required String searchTerm,
    required int page,
  }) async {
    final response = await _remoteDataSource.getExercises(
      searchTerm: searchTerm,
      page: page,
      pageSize: pageSize,
    );
    return response.fold(
      left,
      (rmExercises) => right(rmExercises.map((e) => e.toDomain())),
    );
  }
}
