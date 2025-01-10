// ignore_for_file: unused_field

import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar.dart';
import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar_source.dart';
import 'package:btl/app/coach/features/workouts/data/sources/remote/workout_firestore_source.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

@singleton
final class WorkoutRepository extends ReactiveRepository<Workout, WorkoutFM, WorkoutIsar> {
  final WorkoutFirestoreSource _remoteSource;
  final WorkoutIsarSource _localSource;
  final ExercisesRepository _excsRepository;

  WorkoutRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
    this._excsRepository,
  ) : super(localSource: _localSource, remoteSource: _remoteSource);

  @override
  Future<void> toBeAwaited() =>
      _excsRepository.stream().takeWhileInclusive((status) => !status.isSuccess).last;

  Future<EitherException<void>> saveWorkout({
    required String name,
    required String? description,
    required List<ExerciseSets> exercisesSets,
  }) async {
    try {
      await _remoteSource.saveWorkout(
        coachID: authRepository.user!.id,
        name: name,
        description: description,
        exercisesSets: exercisesSets.map(ExerciseSetsFM.fromDomain).toList(),
      );
      return right(null);
    } catch (e) {
      return left(e as GenericException);
    }
  }

  Future<List<Workout>> searchWorkouts(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final cms = await _localSource.getWorkouts(searchTerm, page: page, pageSize: pageSize);
    return cms.map((e) => e.toDomain()).toList();
  }

  @disposeMethod
  void dispMethod() => dispose();
}
