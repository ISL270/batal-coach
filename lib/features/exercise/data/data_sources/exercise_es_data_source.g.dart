// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_es_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseES _$ExerciseESFromJson(Map<String, dynamic> json) => ExerciseES(
      json['id'] as String?,
      json['name'] as String?,
      json['force'] as String?,
      json['level'] as String?,
      json['mechanic'] as String?,
      json['equipment'] as String?,
      (json['primaryMuscles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      (json['secondaryMuscles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      json['instructions'] as String?,
      json['category'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$ExerciseESToJson(ExerciseES instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'force': instance.force,
      'level': instance.level,
      'mechanic': instance.mechanic,
      'equipment': instance.equipment,
      'primaryMuscles': instance.primaryMuscles?.toList(),
      'secondaryMuscles': instance.secondaryMuscles?.toList(),
      'instructions': instance.instructions,
      'category': instance.category,
      'images': instance.images?.toList(),
    };
