import 'dart:convert';

import 'package:btl/app/coach/features/workouts/data/exercise_details_serializer.dart';
import 'package:btl/app/core/extensions/string_x.dart';
import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:isar/isar.dart';

part 'workout_isar.g.dart';

@collection
final class WorkoutIsar extends CacheModel<Workout> {
  @override
  Id get cacheID => id.fastHash;

  String id;

  String coachID;

  String name;

  String? description;

  List<String> exercisesSets;

  DateTime createdAt;

  WorkoutIsar({
    required this.id,
    required this.coachID,
    required this.name,
    required this.createdAt,
    required this.exercisesSets,
    this.description,
  });

  factory WorkoutIsar.fromDomain(Workout domain) => WorkoutIsar(
        id: domain.id,
        coachID: domain.coachID,
        name: domain.name,
        createdAt: domain.createdAt,
        exercisesSets:
            domain.exercisesSets.map((e) => ExerciseSetsIsar.fromDomain(e).encoded).toList(),
        description: domain.description,
      );

  @override
  Workout toDomain() => Workout(
        id: id,
        coachID: coachID,
        name: name,
        description: description,
        exercisesSets: const [], //TODO: fix this
        createdAt: createdAt,
      );
}

final class ExerciseSetsIsar with ExerciseSetsSerializer {
  final String excID;
  final Map<SET, List<Field>> fields;

  ExerciseSetsIsar(this.excID, this.fields);

  String get encoded => jsonEncode(toMap(excID, fields));

  factory ExerciseSetsIsar.fromDomain(ExerciseSets exerciseSets) =>
      ExerciseSetsIsar(exerciseSets.exercise.id, exerciseSets.fields);
}
