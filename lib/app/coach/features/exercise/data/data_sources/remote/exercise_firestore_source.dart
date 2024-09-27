// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:async';

import 'package:btl/app/coach/features/exercise/data/data_sources/local/exercise_local_data_source.dart';
import 'package:btl/app/coach/features/exercise/data/data_sources/remote/exercise_remote_data_source.dart';
import 'package:btl/app/coach/features/exercise/data/models/remote/exercise_rm.dart';
import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/force.dart';
import 'package:btl/app/coach/features/exercise/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../models/remote/fire_exercise.dart';
part 'exercise_firestore_source.g.dart';

@LazySingleton(as: ExerciseRemoteDataSource)
class ExerciseFirestoreSource implements ExerciseRemoteDataSource {
  final FirestoreService _firestoreSvc;

  ExerciseFirestoreSource(this._firestoreSvc) {
    _createStreams();
  }

  late StreamController<List<_FireExercise>> _updatedExcsCntrlr;

  @override
  Stream<List<ExerciseRM>> get excsToBeUpdated => _updatedExcsCntrlr.stream;

  void _createStreams() {
    _updatedExcsCntrlr = StreamController<List<_FireExercise>>();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _exercisesSubscription;

  @override
  void subToRemote() {
    if (_updatedExcsCntrlr.isClosed) _createStreams();
    _exercisesSubscription = _firestoreSvc.exercises.btlExercises.snapshots().listen(
      (event) async {
        // I encounterd a bug that does not save the docs after login
        // so i think we should always make sure docs count equals local items count
        final count = await getIt.get<ExerciseLocalDataSource>().count;
        if (event.docChanges.isNotEmpty && event.metadata.isFromCache && event.docs.length == count) {
          _updatedExcsCntrlr.addError(const BusinessException(code: 'is_from_cache'));
        } else {
          final excsToBeUpdated = <_FireExercise>[];

          for (final change in event.docChanges) {
            final json = change.doc.data() ?? {};
            if (json.isNotEmpty) {
              excsToBeUpdated.add(_FireExercise.fromJson(json));
            }
          }
          _updatedExcsCntrlr.sink.add(excsToBeUpdated);
        }
      },
      onError: (e) {
        if (e is FirebaseException) {
          throw BusinessException(code: e.code, message: e.message);
        }
        throw NetworkException.unkown();
      },
    );
  }

  @override
  Future<void> cancelRemoteSub() async {
    if (!_updatedExcsCntrlr.isClosed) {
      await _updatedExcsCntrlr.close();
    }
    await _exercisesSubscription?.cancel();
  }

  @override
  @disposeMethod
  void dispose() {
    cancelRemoteSub();
  }
}
