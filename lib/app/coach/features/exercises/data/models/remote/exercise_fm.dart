// ignore_for_file: unused_field

import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/firestore/remote_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_fm.g.dart';

@JsonSerializable(explicitToJson: true)
class ExerciseFM implements RemoteModel<Exercise> {
  final String id;
  final String name;
  final ForceFM? force;
  final LevelFM? level;
  final MechanicFM? mechanic;
  final EquipmentFM? equipment;
  final List<MuscleFM>? primaryMuscles;
  final List<MuscleFM>? secondaryMuscles;
  final List<String>? instructions;
  final CategoryFM? category;
  final TypeFM? type;
  final List<String>? images;
  final List<FieldFM>? fields;

  ExerciseFM(
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
    this.type,
    this.images,
    this.fields,
  );

  factory ExerciseFM.fromJson(Map<String, dynamic> json) => _$ExerciseFMFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseFMToJson(this);

  @override
  Exercise toDomain() => Exercise(
        id: id,
        name: name,
        force: force?.toDomain(),
        level: level?.toDomain(),
        mechanic: mechanic?.toDomain(),
        equipment: equipment?.toDomain(),
        mainMuscle: primaryMuscles?.first.toDomain() ?? MuscleFM.abdominals.toDomain(),
        secondaryMuscles: secondaryMuscles?.map((e) => e.toDomain()).toList() ?? [],
        instructions: instructions ?? [],
        type: category?.typeFromCat(),
        images: images ?? [],
        fieldTypes: _getFields().map((f) => f.toDomain()).toList(),
      );

  factory ExerciseFM.fromDomain(Exercise exc) => ExerciseFM(
        exc.id,
        exc.name,
        exc.force != null ? ForceFM.fromDomain(exc.force!) : null,
        exc.level != null ? LevelFM.fromDomain(exc.level!) : null,
        exc.mechanic != null ? MechanicFM.fromDomain(exc.mechanic!) : null,
        exc.equipment != null ? EquipmentFM.fromDomain(exc.equipment!) : null,
        [MuscleFM.fromDomain(exc.mainMuscle)],
        exc.secondaryMuscles.map(MuscleFM.fromDomain).toList(),
        exc.instructions,
        null,
        exc.type != null ? TypeFM.fromDomain(exc.type!) : null,
        exc.images,
        exc.fieldTypes.map(FieldFM.fromDomain).toList(),
      );

  List<FieldFM> _getFields() {
    if (fields != null) return fields!;
    if (category != null) return _getFieldsByCategory(category!);
    if (type != null) return _getFieldsByType(type!);
    return [];
  }
}

enum EquipmentFM implements RemoteModel<Equipment> {
  barbell,
  dumbbell,
  cable,
  machine,
  kettlebells,
  bands,
  @JsonValue('medicine ball')
  medicineBall,
  @JsonValue('exercise ball')
  exerciseBall,
  @JsonValue('foam roll')
  foamRoll,
  @JsonValue('e-z curl bar')
  ezCurlBar,
  @JsonValue('body only')
  bodyOnly,
  other;

  @override
  Equipment toDomain() => Equipment.values.firstWhere((e) => e.name == name);
  static EquipmentFM fromDomain(Equipment domain) =>
      EquipmentFM.values.firstWhere((e) => e.name == domain.name);
}

enum CategoryFM {
  strength,
  stretching,
  plyometrics,
  @JsonValue('powerlifting')
  powerLifting,
  @JsonValue('olympic weightlifting')
  olympicWeightlifting,
  strongman,
  cardio;

  ExType typeFromCat() => switch (this) {
        CategoryFM.strength => ExType.strength,
        CategoryFM.stretching => ExType.bodyWeight,
        CategoryFM.plyometrics => ExType.bodyWeight,
        CategoryFM.powerLifting => ExType.strength,
        CategoryFM.olympicWeightlifting => ExType.strength,
        CategoryFM.strongman => ExType.strength,
        CategoryFM.cardio => ExType.bodyWeight,
      };
}

enum TypeFM {
  strength,
  bodyWeight,
  timed,
  distance;

  static TypeFM fromDomain(ExType domain) => TypeFM.values.firstWhere((e) => e.name == domain.name);
}

enum LevelFM implements RemoteModel<ExLevel> {
  beginner,
  intermediate,
  expert;

  @override
  ExLevel toDomain() => ExLevel.values.firstWhere((e) => e.name == name);
  static LevelFM fromDomain(ExLevel domain) =>
      LevelFM.values.firstWhere((e) => e.name == domain.name);
}

enum MuscleFM implements RemoteModel<Muscle> {
  quadriceps,
  shoulders,
  abdominals,
  chest,
  hamstrings,
  triceps,
  biceps,
  lats,
  @JsonValue('middle back')
  middleBack,
  calves,
  @JsonValue('lower back')
  lowerBack,
  forearms,
  glutes,
  traps,
  adductors,
  abductors,
  neck;

  @override
  Muscle toDomain() => Muscle.values.firstWhere((e) => e.name == name);
  static MuscleFM fromDomain(Muscle domain) =>
      MuscleFM.values.firstWhere((e) => e.name == domain.name);
}

enum ForceFM implements RemoteModel<Force> {
  pull,
  push,
  static;

  @override
  Force toDomain() => Force.values.firstWhere((e) => e.name == name);
  static ForceFM fromDomain(Force domain) =>
      ForceFM.values.firstWhere((e) => e.name == domain.name);
}

enum MechanicFM implements RemoteModel<Mechanic> {
  compound,
  isolation;

  @override
  Mechanic toDomain() => Mechanic.values.firstWhere((e) => e.name == name);
  static MechanicFM fromDomain(Mechanic domain) =>
      MechanicFM.values.firstWhere((e) => e.name == domain.name);
}

enum FieldFM implements RemoteModel<FieldType> {
  time,
  distance,
  weight,
  reps;

  @override
  FieldType toDomain() => FieldType.values.firstWhere((e) => e.name == name);
  static FieldFM fromDomain(FieldType domain) =>
      FieldFM.values.firstWhere((e) => e.name == domain.name);
}

List<FieldFM> _getFieldsByCategory(CategoryFM category) {
  return switch (category) {
    CategoryFM.strength => [FieldFM.weight, FieldFM.reps],
    CategoryFM.stretching => [FieldFM.reps],
    CategoryFM.plyometrics => [FieldFM.reps],
    CategoryFM.powerLifting => [FieldFM.weight, FieldFM.reps],
    CategoryFM.olympicWeightlifting => [FieldFM.weight, FieldFM.reps],
    CategoryFM.strongman => [FieldFM.weight, FieldFM.reps],
    CategoryFM.cardio => [FieldFM.distance, FieldFM.time],
  };
}

List<FieldFM> _getFieldsByType(TypeFM type) {
  return switch (type) {
    TypeFM.strength => [FieldFM.weight, FieldFM.reps],
    TypeFM.bodyWeight => [FieldFM.reps],
    TypeFM.timed => [FieldFM.time],
    TypeFM.distance => [FieldFM.distance],
  };
}
