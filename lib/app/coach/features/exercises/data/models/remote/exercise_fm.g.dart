// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_fm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseFM _$ExerciseFMFromJson(Map<String, dynamic> json) => ExerciseFM(
      json['id'] as String,
      json['name'] as String,
      $enumDecodeNullable(_$ForceFMEnumMap, json['force']),
      $enumDecodeNullable(_$LevelFMEnumMap, json['level']),
      $enumDecodeNullable(_$MechanicFMEnumMap, json['mechanic']),
      $enumDecodeNullable(_$EquipmentFMEnumMap, json['equipment']),
      (json['primaryMuscles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MuscleFMEnumMap, e))
          .toList(),
      (json['secondaryMuscles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MuscleFMEnumMap, e))
          .toList(),
      (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      $enumDecodeNullable(_$CategoryFMEnumMap, json['category']),
      $enumDecodeNullable(_$TypeFMEnumMap, json['type']),
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['fields'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$FieldFMEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ExerciseFMToJson(ExerciseFM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'force': _$ForceFMEnumMap[instance.force],
      'level': _$LevelFMEnumMap[instance.level],
      'mechanic': _$MechanicFMEnumMap[instance.mechanic],
      'equipment': _$EquipmentFMEnumMap[instance.equipment],
      'primaryMuscles':
          instance.primaryMuscles?.map((e) => _$MuscleFMEnumMap[e]!).toList(),
      'secondaryMuscles':
          instance.secondaryMuscles?.map((e) => _$MuscleFMEnumMap[e]!).toList(),
      'instructions': instance.instructions,
      'category': _$CategoryFMEnumMap[instance.category],
      'type': _$TypeFMEnumMap[instance.type],
      'images': instance.images,
      'fields': instance.fields?.map((e) => _$FieldFMEnumMap[e]!).toList(),
    };

const _$ForceFMEnumMap = {
  ForceFM.pull: 'pull',
  ForceFM.push: 'push',
  ForceFM.static: 'static',
};

const _$LevelFMEnumMap = {
  LevelFM.beginner: 'beginner',
  LevelFM.intermediate: 'intermediate',
  LevelFM.expert: 'expert',
};

const _$MechanicFMEnumMap = {
  MechanicFM.compound: 'compound',
  MechanicFM.isolation: 'isolation',
};

const _$EquipmentFMEnumMap = {
  EquipmentFM.barbell: 'barbell',
  EquipmentFM.dumbbell: 'dumbbell',
  EquipmentFM.cable: 'cable',
  EquipmentFM.machine: 'machine',
  EquipmentFM.kettlebells: 'kettlebells',
  EquipmentFM.bands: 'bands',
  EquipmentFM.medicineBall: 'medicine ball',
  EquipmentFM.exerciseBall: 'exercise ball',
  EquipmentFM.foamRoll: 'foam roll',
  EquipmentFM.ezCurlBar: 'e-z curl bar',
  EquipmentFM.bodyOnly: 'body only',
  EquipmentFM.other: 'other',
};

const _$MuscleFMEnumMap = {
  MuscleFM.quadriceps: 'quadriceps',
  MuscleFM.shoulders: 'shoulders',
  MuscleFM.abdominals: 'abdominals',
  MuscleFM.chest: 'chest',
  MuscleFM.hamstrings: 'hamstrings',
  MuscleFM.triceps: 'triceps',
  MuscleFM.biceps: 'biceps',
  MuscleFM.lats: 'lats',
  MuscleFM.middleBack: 'middle back',
  MuscleFM.calves: 'calves',
  MuscleFM.lowerBack: 'lower back',
  MuscleFM.forearms: 'forearms',
  MuscleFM.glutes: 'glutes',
  MuscleFM.traps: 'traps',
  MuscleFM.adductors: 'adductors',
  MuscleFM.abductors: 'abductors',
  MuscleFM.neck: 'neck',
};

const _$CategoryFMEnumMap = {
  CategoryFM.strength: 'strength',
  CategoryFM.stretching: 'stretching',
  CategoryFM.plyometrics: 'plyometrics',
  CategoryFM.powerLifting: 'powerlifting',
  CategoryFM.olympicWeightlifting: 'olympic weightlifting',
  CategoryFM.strongman: 'strongman',
  CategoryFM.cardio: 'cardio',
};

const _$TypeFMEnumMap = {
  TypeFM.strength: 'strength',
  TypeFM.bodyWeight: 'bodyWeight',
  TypeFM.timed: 'timed',
  TypeFM.distance: 'distance',
};

const _$FieldFMEnumMap = {
  FieldFM.time: 'time',
  FieldFM.distance: 'distance',
  FieldFM.weight: 'weight',
  FieldFM.reps: 'reps',
};
