import 'package:btl/app/coach/features/exercise/data/data_sources/local/exercise_local_data_source.dart';
import 'package:btl/app/coach/features/exercise/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';
import 'package:btl/app/core/services/local_db/isar_db.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@Singleton(as: ExerciseLocalDataSource)
final class ExerciseIsarSource implements ExerciseLocalDataSource {
  @override
  final LocalDB localDB;

  const ExerciseIsarSource(this.localDB);

  @override
  Future<List<int>> updateExercises(List<Exercise> exercises) =>
      localDB.putAll<ExerciseIsar>(exercises.map(ExerciseIsar.fromDomain).toList());

  @override
  Future<int> deleteExercises(List<int> ids) => localDB.deleteAll<ExerciseIsar>(ids);

  @override
  Future<List<ExerciseIsar>> getExercises(
    String searchTerm,
    int page,
    int pageSize,
  ) async {
    late final List<ExerciseIsar> result;

    if (searchTerm.isBlank) {
      result = await (localDB as IsarDB)
          .isar
          .exerciseIsars
          .where()
          .anyName()
          .offset(page * pageSize)
          .limit(pageSize)
          .findAll();
    } else {
      result = await (localDB as IsarDB)
          .isar
          .exerciseIsars
          .where()
          .nameStartsWith(searchTerm)
          .offset(page * pageSize)
          .limit(pageSize)
          .findAll();
    }

    return result;
  }

  @override
  Future<void> clearExercises() => localDB.clear<ExerciseIsar>();
}
