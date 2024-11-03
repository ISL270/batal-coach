// ignore_for_file: inference_failure_on_untyped_parameter

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
  final ExercisesFirestoreSource excsRemoteSource;
  final ExercisesIsarSource excsLocalSource;

  ExercisesRepository(
    super.authRepository,
    this.excsRemoteSource,
    this.excsLocalSource,
  ) : super(localSource: excsLocalSource, remoteSource: excsRemoteSource);

  Future<List<Exercise>> getExercises(
    String searchTerm,
    ExcFilters? filters, {
    required int page,
    required int pageSize,
  }) async {
    final cmExercises = await excsLocalSource.getExercises(searchTerm, filters, page, pageSize);
    return cmExercises.map((e) => e.toDomain()).toList();
  }

  Future<List<Exercise>> getExcsByIDs(List<String> ids) async {
    final cmExercises = await excsLocalSource.getExercisesByIDs(ids);
    return cmExercises.map((e) => e.toDomain()).toList();
  }

  Future<Exercise?> getExercise(String id) async {
    final cmExercise = await excsLocalSource.getExercise(id);
    return cmExercise?.toDomain();
  }

  Future<void> clearLocalDB() => excsLocalSource.clear();

  Future<List<int>> updateLocalDB(List<Exercise> domainModels) =>
      excsLocalSource.putAll(domainModels);

  @disposeMethod
  void dispMethod() => dispose();
}
