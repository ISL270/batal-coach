import 'dart:convert';

import 'package:btl/app/coach/features/workouts/data/exercise_details_serializer.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/firestore_source.dart';
import 'package:btl/app/core/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

part 'workout_fs.dart';

@lazySingleton
final class WorkoutFirestoreSource extends FirestoreSource {
  final FirestoreService _firestoreSvc;

  const WorkoutFirestoreSource(this._firestoreSvc);

  Future<WorkoutFS> saveWorkout({
    required String coachID,
    required String name,
    required String? description,
    required List<ExerciseSetsFS> exercisesSets,
  }) async =>
      firestoreOperationHandler(() async {
        final newWorkoutRef = await _firestoreSvc.workouts.collection.add({
          _firestoreSvc.workouts.coachIdField: coachID,
          _firestoreSvc.workouts.nameField: name,
          _firestoreSvc.workouts.descriptionField: description,
          _firestoreSvc.workouts.exercisesSetsField: exercisesSets.map(jsonEncode).toList(),
          _firestoreSvc.workouts.createdAtField: FieldValue.serverTimestamp(),
        });

        final newWorkoutSnapshot = await newWorkoutRef.get();
        final createdAtTS = newWorkoutSnapshot[_firestoreSvc.workouts.createdAtField] as Timestamp?;

        return WorkoutFS(
          id: newWorkoutRef.id,
          coachID: coachID,
          name: name,
          description: description,
          exercisesSets: exercisesSets,
          createdAt: createdAtTS?.toDate() ?? DateTime.now(),
        );
      });
}
