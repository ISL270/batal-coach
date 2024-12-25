import 'dart:convert';

import 'package:btl/app/coach/features/exercises/data/data_sources/local/exercises_isar_source.dart';
import 'package:btl/app/coach/features/workouts/data/exercise_details_serializer.dart';
import 'package:btl/app/core/firestore/firestore_helper.dart';
import 'package:btl/app/core/firestore/reactive_firestore_source.dart';
import 'package:btl/app/core/firestore/remote_model.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

part 'workout_fm.dart';

@singleton
final class WorkoutFirestoreSource extends ReactiveFirestoreSource<WorkoutFM> with FirestoreHelper {
  WorkoutFirestoreSource(super.firestoreSvc);

  Future<void> saveWorkout({
    required String coachID,
    required String name,
    required String? description,
    required List<ExerciseSetsFM> exercisesSets,
  }) async =>
      firestoreOperationHandler(() async {
        await firestoreSvc.workouts.collection.add({
          firestoreSvc.workouts.coachIdField: coachID,
          firestoreSvc.workouts.nameField: name,
          firestoreSvc.workouts.descriptionField: description,
          firestoreSvc.workouts.exercisesSetsField: exercisesSets.map(jsonEncode).toList(),
          firestoreSvc.workouts.createdAtField: FieldValue.serverTimestamp(),
        });
      });

  @override
  WorkoutFM fromJson(String docID, Map<String, dynamic> json) => WorkoutFM.fromJson(docID, json);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotQuery(User user) =>
      firestoreSvc.workouts.collection
          .where(firestoreSvc.workouts.coachIdField, isEqualTo: user.id)
          .snapshots();
}
