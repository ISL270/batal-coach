import 'dart:convert';

import 'package:btl/app/coach/features/workouts/data/exercise_details_serializer.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/firestore_source.dart';
import 'package:btl/app/core/models/reactive_firestore_source.dart';
import 'package:btl/app/core/models/remote_model.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

part 'workout_fm.dart';

@singleton
final class WorkoutFirestoreSource extends ReactiveFirestoreSource<WorkoutFM> with FirestoreSource {
  WorkoutFirestoreSource(super.firestoreSvc);

  Future<WorkoutFM> saveWorkout({
    required String coachID,
    required String name,
    required String? description,
    required List<ExerciseSetsFM> exercisesSets,
  }) async =>
      firestoreOperationHandler(() async {
        final newWorkoutRef = await firestoreSvc.workouts.collection.add({
          firestoreSvc.workouts.coachIdField: coachID,
          firestoreSvc.workouts.nameField: name,
          firestoreSvc.workouts.descriptionField: description,
          firestoreSvc.workouts.exercisesSetsField: exercisesSets.map(jsonEncode).toList(),
          firestoreSvc.workouts.createdAtField: FieldValue.serverTimestamp(),
        });

        final newWorkoutSnapshot = await newWorkoutRef.get();
        final createdAtTS = newWorkoutSnapshot[firestoreSvc.workouts.createdAtField] as Timestamp?;

        return WorkoutFM(
          id: newWorkoutRef.id,
          coachID: coachID,
          name: name,
          description: description,
          exercisesSets: exercisesSets,
          createdAt: createdAtTS?.toDate() ?? DateTime.now(),
        );
      });

  @override
  WorkoutFM fromJson(String docID, Map<String, dynamic> json) => WorkoutFM.fromJson(docID, json);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotQuery(User coach) =>
      firestoreSvc.workouts.collection
          .where(firestoreSvc.workouts.coachIdField, isEqualTo: coach.id)
          .snapshots();
}
