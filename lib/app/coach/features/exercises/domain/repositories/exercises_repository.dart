// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:btl/app/coach/features/exercises/data/data_sources/local/exercises_local_data_source.dart';
import 'package:btl/app/coach/features/exercises/data/data_sources/remote/exercises_remote_data_source.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:btl/app/features/authentication/domain/models/user_x.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
class ExercisesRepository implements ReactiveRepository<VoidStatus> {
  final AuthRepository _authRepository;
  final ExercisesRemoteDataSource _remoteSource;
  final ExercisesLocalDataSource _localSource;

  ExercisesRepository(
    this._authRepository,
    this._remoteSource,
    this._localSource,
  ) {
    _createSubject();
    _init();
  }

  late BehaviorSubject<VoidStatus> _subject;

  @override
  Stream<VoidStatus> getUpdates() => _subject.asBroadcastStream();

  void _createSubject() => _subject = BehaviorSubject<VoidStatus>.seeded(const Initial());

  void _closeSubject() {
    if (_subject.isClosed) return;
    _subject.close();
  }

  void _init() {
    _authRepository.getUpdates().listen((user) {
      if (user?.isTrainee ?? true) {
        _remoteSource.cancelRemoteSub();
        _localSource.clearExercises();
        _closeSubject();
        return;
      }
      if (_subject.isClosed) _createSubject();
      _subject.add(const Loading());
      _remoteSource.subToRemote();
      _remoteSource.excsToBeUpdated.listen(
        (rmExercises) async {
          await _localSource.updateExercises(rmExercises.map((e) => e.toDomain()).toList());
          _subject.add(const Success(null));
        },
        onError: (e) {
          final exception = e as GenericException;

          if (exception.code == 'is_from_cache') {
            _subject.add(const Success(null));
            return;
          }
          _subject.add(Failure(exception));
        },
      );
    });
  }

  Future<List<Exercise>> getExercises(
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

  @override
  @disposeMethod
  void dispose() {
    _remoteSource.dispose();
    _closeSubject();
  }
}
