// ignore_for_file: inference_failure_on_untyped_parameter, unused_field

import 'package:btl/app/coach/features/exercises/data/data_sources/local/exercises_isar_source.dart';
import 'package:btl/app/coach/features/exercises/data/data_sources/remote/exercises_firestore_source.dart';
import 'package:btl/app/coach/features/exercises/data/models/local/exercise_isar.dart';
import 'package:btl/app/coach/features/exercises/data/models/remote/exercise_fm.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ExercisesRepository extends ReactiveRepository<Exercise, ExerciseFM, ExerciseIsar> {
  final ExercisesFirestoreSource _remoteSource;
  final ExercisesIsarSource _localSource;

  ExercisesRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
  ) : super(localSource: _localSource, remoteSource: _remoteSource);

  Future<List<Exercise>> searchExercises(
    String searchTerm,
    ExcFilters? filters, {
    required int page,
    required int pageSize,
  }) async {
    final cmExercises = await _localSource.getExercises(searchTerm, filters, page, pageSize);
    return cmExercises.map((e) => e.toDomain()).toList();
  }

  Future<List<Exercise>> getExcsByIDs(List<String> ids) async {
    final cmExercises = await _localSource.getExercisesByIDs(ids);
    return cmExercises.map((e) => e.toDomain()).toList();
  }

  Future<Exercise?> getExercise(String id) async {
    final cmExercise = await _localSource.getExercise(id);
    return cmExercise?.toDomain();
  }

  Future<void> clearLocalDB() => _localSource.clear();

  Future<List<int>> updateLocalDB(List<Exercise> domainModels) => _localSource.putAll(domainModels);

  @disposeMethod
  void dispMethod() => dispose();
}
