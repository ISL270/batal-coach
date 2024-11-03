import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar_source.dart';
import 'package:btl/app/coach/features/workouts/data/sources/remote/workout_firestore_source.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
final class WorkoutRepository extends ReactiveRepository<Workout, WorkoutFM, WorkoutIsar> {
  final WorkoutFirestoreSource wksRemoteSource;
  final WorkoutIsarSource wksLocalSource;

  WorkoutRepository(
    super.authRepository,
    this.wksRemoteSource,
    this.wksLocalSource,
  ) : super(localSource: wksLocalSource, remoteSource: wksRemoteSource);

  Future<EitherException<Workout>> saveWorkout({
    required String name,
    required String? description,
    required List<ExerciseSets> exercisesSets,
  }) async {
    try {
      final workoutFS = await wksRemoteSource.saveWorkout(
        coachID: authRepository.user!.id,
        name: name,
        description: description,
        exercisesSets: exercisesSets.map(ExerciseSetsFM.fromDomain).toList(),
      );

      final workout = workoutFS.toDomain(exercisesSets);

      await wksLocalSource.putWorkout(WorkoutIsar.fromDomain(workout));

      return right(workout);
    } catch (e) {
      return left(e as GenericException);
    }
  }

  @disposeMethod
  void dispMethod() => dispose();
}
