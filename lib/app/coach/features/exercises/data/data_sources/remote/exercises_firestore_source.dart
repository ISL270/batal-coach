// ignore_for_file: inference_failure_on_untyped_parameter, library_private_types_in_public_api

import 'dart:async';

import 'package:btl/app/coach/features/exercises/data/models/remote/exercise_fm.dart';
import 'package:btl/app/core/firestore/reactive_firestore_source.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ExercisesFirestoreSource extends ReactiveFirestoreSource<ExerciseFM> {
  ExercisesFirestoreSource(super.firestoreSvc);

  @override
  ExerciseFM fromJson(String docID,Map<String, dynamic> json) => ExerciseFM.fromJson(json);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotQuery(User user) =>
      firestoreSvc.exercises.btlExercises.snapshots();

  @disposeMethod
  void dispMethod() => dispose();
}
