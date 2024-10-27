// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutRM _$WorkoutRMFromJson(Map<String, dynamic> json) => WorkoutRM(
      name: json['name'] as String,
      description: json['description'] as String?,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseDetailsRM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutRMToJson(WorkoutRM instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
