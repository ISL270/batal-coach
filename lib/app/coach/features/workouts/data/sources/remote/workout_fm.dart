part of 'workout_firestore_source.dart';

final class WorkoutFM implements RemoteModel<Workout> {
  @override
  final String id;
  final String coachID;
  final String name;
  final String? description;
  final List<ExerciseSetsFM> exercisesSets;
  final DateTime createdAt;

  WorkoutFM({
    required this.id,
    required this.coachID,
    required this.name,
    required this.description,
    required this.exercisesSets,
    required this.createdAt,
  });

  factory WorkoutFM.fromJson(String docID, Map<String, dynamic> json) => WorkoutFM(
        id: docID,
        coachID: json['coachID'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        exercisesSets: (json['exercisesSets'] as List<dynamic>)
            .map((e) => ExerciseSetsFM.fromJson(jsonDecode(e as String) as Map<String, dynamic>))
            .toList(),
        createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  @override
  Workout toDomain([List<ExerciseSets>? domainExcsSets]) => Workout(
        id: id,
        coachID: coachID,
        name: name,
        description: description,
        exercisesSets: domainExcsSets ?? exercisesSets.map((e) => e.toDomain()).toList(),
        createdAt: createdAt,
      );
}

final class ExerciseSetsFM with ExerciseSetsSerializer {
  final String excID;
  final Map<SET, List<Field>> fields;

  ExerciseSetsFM(this.excID, this.fields);

  factory ExerciseSetsFM.fromDomain(ExerciseSets details) => ExerciseSetsFM(
        details.exercise.id,
        details.fields,
      );

  Map<String, dynamic> toJson() => toMap(excID, fields);

  factory ExerciseSetsFM.fromJson(Map<String, dynamic> json) {
    final (excID, fields) = ExerciseSetsSerializer.fromMap(json);
    return ExerciseSetsFM(excID, fields);
  }

  ExerciseSets toDomain() {
    final excIsar = getIt.get<ExercisesIsarSource>().getExerciseSync(excID);
    return ExerciseSets(excIsar!.toDomain(), fields: fields);
  }
}
