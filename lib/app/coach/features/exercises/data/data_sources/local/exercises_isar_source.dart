// ignore_for_file: inference_failure_on_function_invocation

import 'package:btl/app/coach/features/exercises/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/models/isar_source.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@singleton
final class ExercisesIsarSource extends IsarSource<Exercise, ExerciseIsar> {
  const ExercisesIsarSource(super.isarService);

  Future<int> deleteExercises(List<String> ids) => isarService.deleteAll<ExerciseIsar>(ids);

  Future<List<ExerciseIsar>> getExercises(
    String searchTerm,
    ExcFilters? filters,
    int page,
    int pageSize,
  ) async {
    final query = switch (searchTerm.isNotBlank) {
      true => isarService.instance.exerciseIsars.where().nameStartsWith(searchTerm).filter(),
      false => isarService.instance.exerciseIsars.where().anyName().filter(),
    };
    return query
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

  Future<List<ExerciseIsar>> getExercisesByIDs(List<String> ids) async {
    return isarService.getAllByIDs<ExerciseIsar>(ids);
  }

  Future<ExerciseIsar?> getExercise(String id) async {
    return isarService.get<ExerciseIsar>(id);
  }

  ExerciseIsar? getExerciseSync(String id) => isarService.getSync<ExerciseIsar>(id);

  @override
  ExerciseIsar fromDomain(Exercise dm) => ExerciseIsar.fromDomain(dm);
}
