import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar_source.dart';
import 'package:btl/app/coach/features/workouts/data/sources/remote/workout_firestore_source.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class WorkoutRepository {
  final AuthRepository _authRepository;
  final WorkoutFirestoreSource _remoteSource;
  final WorkoutIsarSource _localSource;

  const WorkoutRepository(
    this._authRepository,
    this._remoteSource,
    this._localSource,
  );

  Future<EitherException<Workout>> saveWorkout({
    required String name,
    required String? description,
    required List<ExerciseSets> exercisesSets,
  }) async {
    try {
      final workoutFS = await _remoteSource.saveWorkout(
        coachID: _authRepository.user!.id,
        name: name,
        description: description,
        exercisesSets: exercisesSets.map(ExerciseSetsFS.fromDomain).toList(),
      );

      final workout = workoutFS.toDomain(exercisesSets);

      await _localSource.putWorkout(WorkoutIsar.fromDomain(workout));

      return right(workout);
    } catch (e) {
      return left(e as GenericException);
    }
  }
}
