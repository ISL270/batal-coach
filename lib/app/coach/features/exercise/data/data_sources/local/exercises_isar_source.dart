// ignore_for_file: inference_failure_on_function_invocation

import 'package:btl/app/coach/features/exercise/data/data_sources/local/exercises_local_data_source.dart';
import 'package:btl/app/coach/features/exercise/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercise/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';
import 'package:btl/app/core/services/local_db/isar_db.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@Singleton(as: ExercisesLocalDataSource)
final class ExercisesIsarSource implements ExercisesLocalDataSource {
  @override
  final LocalDB localDB;

  const ExercisesIsarSource(this.localDB);

  @override
  Future<List<int>> updateExercises(List<Exercise> exercises) =>
      localDB.putAll<ExerciseIsar>(exercises.map(ExerciseIsar.fromDomain).toList());

  @override
  Future<int> deleteExercises(List<int> ids) => localDB.deleteAll<ExerciseIsar>(ids);

  @override
  Future<List<ExerciseIsar>> getExercises(
    String searchTerm,
    ExFilters? filters,
    int page,
    int pageSize,
  ) async {
    final exFilter = switch (searchTerm.isNotBlank) {
      true => (localDB as IsarDB).isar.exerciseIsars.where().nameStartsWith(searchTerm).filter(),
      false => (localDB as IsarDB).isar.exerciseIsars.where().anyName().filter(),
    };
    return exFilter
        .optional(
          filters?.muscles.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.muscles,
            (q, muscle) => q.mainMuscleEqualTo(muscle),
          ),
        )
        .optional(
          filters?.equipment.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.equipment,
            (ex, equipment) => ex.equipmentEqualTo(equipment),
          ),
        )
        .optional(
          filters?.category.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.category,
            (ex, category) => ex.categoryEqualTo(category),
          ),
        )
        .optional(
          filters?.level.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.level,
            (ex, level) => ex.levelEqualTo(level),
          ),
        )
        // .optional(
        //   filters?.owership.isNotEmpty ?? false,
        //   (ex) => ex.anyOf(
        //     filters!.equipment,
        //     (ex, equipment) => ex.equipmentEqualTo(equipment),
        //   ),
        // )
        .offset(page * pageSize)
        .limit(pageSize)
        .findAll();
  }

  @override
  Future<void> clearExercises() => localDB.clear<ExerciseIsar>();
}
