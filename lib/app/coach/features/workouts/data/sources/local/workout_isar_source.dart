import 'dart:async';

import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/core/isar/isar_source.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@singleton
final class WorkoutIsarSource extends IsarSource<Workout, WorkoutIsar> {
  WorkoutIsarSource(super.isarService);

  @override
  WorkoutIsar fromDomain(Workout dm) => WorkoutIsar.fromDomain(dm);

  Future<List<WorkoutIsar>> getWorkouts(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final query = switch (searchTerm.isNotBlank) {
      true => isarService.instance.workoutIsars.where().nameStartsWith(searchTerm),
      false => isarService.instance.workoutIsars.where().anyName(),
    };
    return query.offset(page * pageSize).limit(pageSize).findAll();
  }
}
