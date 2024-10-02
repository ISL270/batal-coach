// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_firestore_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FireExercise _$FireExerciseFromJson(Map<String, dynamic> json) =>
    _FireExercise(
      json['id'] as String,
      json['name'] as String,
      $enumDecodeNullable(_$_ForceEnumMap, json['force']),
      $enumDecodeNullable(_$_LevelEnumMap, json['level']),
      $enumDecodeNullable(_$_MechanicEnumMap, json['mechanic']),
      $enumDecodeNullable(_$_EquipmentEnumMap, json['equipment']),
      (json['primaryMuscles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$_MuscleEnumMap, e))
          .toList(),
      (json['secondaryMuscles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$_MuscleEnumMap, e))
          .toList(),
      (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      $enumDecodeNullable(_$_CategoryEnumMap, json['category']),
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FireExerciseToJson(_FireExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'force': _$_ForceEnumMap[instance.force],
      'level': _$_LevelEnumMap[instance.level],
      'mechanic': _$_MechanicEnumMap[instance.mechanic],
      'equipment': _$_EquipmentEnumMap[instance.equipment],
      'primaryMuscles':
          instance.primaryMuscles?.map((e) => _$_MuscleEnumMap[e]!).toList(),
      'secondaryMuscles':
          instance.secondaryMuscles?.map((e) => _$_MuscleEnumMap[e]!).toList(),
      'instructions': instance.instructions,
      'category': _$_CategoryEnumMap[instance.category],
      'images': instance.images,
    };

const _$_ForceEnumMap = {
  _Force.pull: 'pull',
  _Force.push: 'push',
  _Force.static: 'static',
};

const _$_LevelEnumMap = {
  _Level.beginner: 'beginner',
  _Level.intermediate: 'intermediate',
  _Level.expert: 'expert',
};

const _$_MechanicEnumMap = {
  _Mechanic.compound: 'compound',
  _Mechanic.isolation: 'isolation',
};

const _$_EquipmentEnumMap = {
  _Equipment.barbell: 'barbell',
  _Equipment.dumbbell: 'dumbbell',
  _Equipment.cable: 'cable',
  _Equipment.machine: 'machine',
  _Equipment.kettlebells: 'kettlebells',
  _Equipment.bands: 'bands',
  _Equipment.medicineBall: 'medicine ball',
  _Equipment.exerciseBall: 'exercise ball',
  _Equipment.foamRoll: 'foam roll',
  _Equipment.ezCurlBar: 'e-z curl bar',
  _Equipment.bodyOnly: 'body only',
  _Equipment.other: 'other',
};

const _$_MuscleEnumMap = {
  _Muscle.quadriceps: 'quadriceps',
  _Muscle.shoulders: 'shoulders',
  _Muscle.abdominals: 'abdominals',
  _Muscle.chest: 'chest',
  _Muscle.hamstrings: 'hamstrings',
  _Muscle.triceps: 'triceps',
  _Muscle.biceps: 'biceps',
  _Muscle.lats: 'lats',
  _Muscle.middleBack: 'middle back',
  _Muscle.calves: 'calves',
  _Muscle.lowerBack: 'lower back',
  _Muscle.forearms: 'forearms',
  _Muscle.glutes: 'glutes',
  _Muscle.traps: 'traps',
  _Muscle.adductors: 'adductors',
  _Muscle.abductors: 'abductors',
  _Muscle.neck: 'neck',
};

const _$_CategoryEnumMap = {
  _Category.strength: 'strength',
  _Category.stretching: 'stretching',
  _Category.plyometrics: 'plyometrics',
  _Category.powerLifting: 'powerlifting',
  _Category.olympicWeightlifting: 'olympic weightlifting',
  _Category.strongman: 'strongman',
  _Category.cardio: 'cardio',
};
