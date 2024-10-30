import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/core/services/local_db/i_local_db.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class WorkoutIsarSource {
  final LocalDB _localDB;

  const WorkoutIsarSource(this._localDB);

  Future<int> putWorkout(WorkoutIsar workout) => _localDB.put<WorkoutIsar>(workout);
}
