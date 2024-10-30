part of 'workout_firestore_source.dart';

final class WorkoutFS {
  final String id;
  final String coachID;
  final String name;
  final String? description;
  final List<ExerciseSetsFS> exercisesSets;
  final DateTime createdAt;

  WorkoutFS({
    required this.id,
    required this.coachID,
    required this.name,
    required this.description,
    required this.exercisesSets,
    required this.createdAt,
  });

  factory WorkoutFS.fromJson(Map<String, dynamic> json) => WorkoutFS(
        id: json['id'] as String,
        coachID: json['coachID'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        exercisesSets: (json['exercisesSets'] as List<dynamic>)
            .map((e) => ExerciseSetsFS.fromJson(jsonDecode(e as String) as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Workout toDomain(List<ExerciseSets> exercisesSets) => Workout(
        id: id,
        coachID: coachID,
        name: name,
        description: description,
        exercisesSets: exercisesSets,
        createdAt: createdAt,
      );
}

final class ExerciseSetsFS with ExerciseSetsSerializer {
  final String excID;
  final Map<SET, List<Field>> fields;

  ExerciseSetsFS(this.excID, this.fields);

  factory ExerciseSetsFS.fromDomain(ExerciseSets details) => ExerciseSetsFS(
        details.exercise.id,
        details.fields,
      );

  Map<String, dynamic> toJson() => toMap(excID, fields);

  factory ExerciseSetsFS.fromJson(Map<String, dynamic> json) {
    final (excID, fields) = ExerciseSetsSerializer.fromMap(json);
    return ExerciseSetsFS(excID, fields);
  }
}
