// ignore_for_file: inference_failure_on_function_invocation

import 'package:btl/app/coach/features/exercises/data/data_sources/local/exercises_local_data_source.dart';
import 'package:btl/app/coach/features/exercises/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
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
  Future<int> deleteExercises(List<String> ids) => localDB.deleteAll<ExerciseIsar>(ids);

  @override
  Future<List<ExerciseIsar>> getExercises(
    String searchTerm,
    ExcFilters? filters,
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
          filters?.equipments.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.equipments,
            (ex, equipment) => ex.equipmentEqualTo(equipment),
          ),
        )
        .optional(
          filters?.types.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.types,
            (ex, category) => ex.typeEqualTo(category),
          ),
        )
        .optional(
          filters?.levels.isNotEmpty ?? false,
          (ex) => ex.anyOf(
            filters!.levels,
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

  @override
  Future<List<ExerciseIsar>> getExercisesByIDs(List<String> ids) async {
    return localDB.getAllByIDs<ExerciseIsar>(ids);
  }

  @override
  Future<ExerciseIsar?> getExercise(String id) async {
    return localDB.get<ExerciseIsar>(id);
  }
}
