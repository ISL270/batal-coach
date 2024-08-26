part of '../data_sources/exercise_algolia_data_source.dart';

@JsonSerializable()
class ExerciseAlgolia implements ExerciseRM {
  @JsonKey(name: 'id')
  @override
  final String? id;
  @JsonKey(name: 'name')
  @override
  final String? name;
  @JsonKey(name: 'force')
  @override
  final String? force;
  @JsonKey(name: 'level')
  @override
  final String? level;
  @JsonKey(name: 'mechanic')
  @override
  final String? mechanic;
  @JsonKey(name: 'equipment')
  @override
  final String? equipment;
  @JsonKey(name: 'primaryMuscles')
  @override
  final Set<String>? primaryMuscles;
  @JsonKey(name: 'secondaryMuscles')
  @override
  final Set<String>? secondaryMuscles;
  @JsonKey(name: 'instructions')
  @override
  final String? instructions;
  @JsonKey(name: 'category')
  @override
  final String? category;
  @JsonKey(name: 'images')
  @override
  final Set<String>? images;

  const ExerciseAlgolia(
    this.id,
    this.name,
    this.force,
    this.level,
    this.mechanic,
    this.equipment,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.instructions,
    this.category,
    this.images,
  );

  factory ExerciseAlgolia.fromJson(Map<String, dynamic> json) => _$ExerciseAlgoliaFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseAlgoliaToJson(this);
}
