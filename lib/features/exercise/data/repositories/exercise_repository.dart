import 'package:btl/features/exercise/data/data_sources/exercise_remote_data_source.dart';
import 'package:btl/features/exercise/data/models/exercise_rm.dart';
import 'package:btl/features/exercise/domain/models/exercise.dart';
import 'package:injectable/injectable.dart';

@singleton
class ExerciseRepository {
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepository(this._remoteDataSource);

  Future<Iterable<Exercise>> getExercises() async {
    final rmExercises = await _remoteDataSource.getExercises();
    return rmExercises.map((e) => e.toDomain());
  }
}
