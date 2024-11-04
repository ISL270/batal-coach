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
  final WorkoutFirestoreSource _wksRemoteSource;
  final WorkoutIsarSource _wksLocalSource;
  final ExercisesRepository _excsRepository;

  WorkoutRepository(
    super.authRepository,
    this._wksRemoteSource,
    this._wksLocalSource,
    this._excsRepository,
  ) : super(localSource: _wksLocalSource, remoteSource: _wksRemoteSource);

  @override
  Future<void>? get toBeAwaited =>
      _excsRepository.getUpdates().takeWhileInclusive((status) => !status.isSuccess).last;

  Future<EitherException<void>> saveWorkout({
    required String name,
    required String? description,
    required List<ExerciseSets> exercisesSets,
  }) async {
    try {
      await _wksRemoteSource.saveWorkout(
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

  @disposeMethod
  void dispMethod() => dispose();
}
