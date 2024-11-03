import 'dart:async';

import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/isar_source.dart';
import 'package:injectable/injectable.dart';

@singleton
final class WorkoutIsarSource extends IsarSource<Workout, WorkoutIsar> {
  WorkoutIsarSource(super.localDB);

  Future<int> putWorkout(WorkoutIsar workout) => localDB.put<WorkoutIsar>(workout);

  Future<List<WorkoutIsar>> getAllWorkouts() => localDB.getAll<WorkoutIsar>();

  @override
  WorkoutIsar fromDomain(Workout dm) => WorkoutIsar.fromDomain(dm);
}
