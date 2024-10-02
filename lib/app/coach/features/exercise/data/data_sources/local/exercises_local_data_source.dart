import 'package:btl/app/coach/features/exercise/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercise/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';

abstract interface class ExercisesLocalDataSource {
  final LocalDB localDB;
  const ExercisesLocalDataSource(this.localDB);

  Future<List<int>> updateExercises(List<Exercise> exercises);

  Future<int> deleteExercises(List<int> ids);

  Future<List<ExerciseIsar>> getExercises(
    String searchTerm,
    ExFilters? filters,
    int page,
    int pageSize,
  );

  Future<void> clearExercises();

  Future<int> get count;
}
