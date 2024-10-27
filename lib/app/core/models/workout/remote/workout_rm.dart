import 'package:btl/app/core/models/workout/remote/exercise_details_rm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_rm.g.dart';

@JsonSerializable(explicitToJson: true)
final class WorkoutRM {
  final String name;
  final String? description;
  final List<ExerciseDetailsRM> exercises;

  WorkoutRM({
    required this.name,
    required this.description,
    required this.exercises,
  });

  factory WorkoutRM.fromJson(Map<String, dynamic> json) => _$WorkoutRMFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutRMToJson(this);
}
