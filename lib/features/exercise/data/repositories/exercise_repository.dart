import 'package:btl/core/generic_exception.dart';
import 'package:btl/features/exercise/data/data_sources/exercise_remote_data_source.dart';
import 'package:btl/features/exercise/data/models/exercise_rm.dart';
import 'package:btl/features/exercise/domain/models/exercise.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
class ExerciseRepository {
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepository(this._remoteDataSource);

  Future<Either<GenericException, Iterable<Exercise>>> getExercises(String searchTerm) async {
    final response = await _remoteDataSource.getExercises(searchTerm: searchTerm);
    return response.fold(
      left,
      (rmExercises) => right(rmExercises.map((e) => e.toDomain())),
    );
  }
}
