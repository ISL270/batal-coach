import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:equatable/equatable.dart';

final class Workout extends Equatable {
  final String id;
  final String coachID;
  final String name;
  final String? description;
  final List<ExerciseSets> exercisesSets;
  final DateTime createdAt;

  const Workout({
    required this.id,
    required this.coachID,
    required this.name,
    required this.description,
    required this.exercisesSets,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, coachID, name, description, exercisesSets, createdAt];
}

final class ExerciseSets extends Equatable {
  final Exercise exercise;
  late final Map<SET, List<Field>> fields;

  ExerciseSets(this.exercise, {Map<SET, List<Field>>? fields}) {
    if (fields != null) {
      this.fields = fields;
    } else {
      this.fields = {Regular.first(): exercise.initialFields()};
    }
  }

  @override
  List<Object?> get props => [exercise, fields];
}
