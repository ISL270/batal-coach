// ignore_for_file: unused_field

part of '../../data_sources/remote/exercises_firestore_source.dart';

@JsonSerializable(explicitToJson: true)
class _FireExercise implements ExerciseRM {
  @override
  final String id;
  @override
  final String name;
  final _Force? force;
  final _Level? level;
  final _Mechanic? mechanic;
  final _Equipment? equipment;
  final List<_Muscle>? primaryMuscles;
  final List<_Muscle>? secondaryMuscles;
  @override
  final List<String>? instructions;
  final _Category? category;
  @override
  final List<String>? images;
  final List<_Field> fields;

  _FireExercise(
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
    this.fields,
  );
  factory _FireExercise.fromJson(Map<String, dynamic> json) => _$FireExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$FireExerciseToJson(this);

  @override
  Exercise toDomain() => Exercise(
        id: id,
        name: name,
        force: force?.toDomain(),
        level: level?.toDomain(),
        mechanic: mechanic?.toDomain(),
        equipment: equipment?.toDomain(),
        mainMuscle: primaryMuscles?.first.toDomain() ?? _Muscle.abdominals.toDomain(),
        secondaryMuscles: secondaryMuscles?.map((e) => e.toDomain()).toList() ?? [],
        instructions: instructions ?? [],
        category: category?.toDomain(),
        images: images ?? [],
        fields: fields.map((f) => f.toDomain()).toList(),
      );

  factory _FireExercise.fromDomain(Exercise exc) => _FireExercise(
        exc.id,
        exc.name,
        exc.force != null ? _Force.fromDomain(exc.force!) : null,
        exc.level != null ? _Level.fromDomain(exc.level!) : null,
        exc.mechanic != null ? _Mechanic.fromDomain(exc.mechanic!) : null,
        exc.equipment != null ? _Equipment.fromDomain(exc.equipment!) : null,
        [_Muscle.fromDomain(exc.mainMuscle)],
        exc.secondaryMuscles.map(_Muscle.fromDomain).toList(),
        exc.instructions,
        exc.category != null ? _Category.fromDomain(exc.category!) : null,
        exc.images,
        exc.fields.map(_Field.fromDomain).toList(),
      );
}

enum _Equipment {
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

  Equipment toDomain() => Equipment.values.firstWhere((e) => e.name == name);
  static _Equipment fromDomain(Equipment domain) =>
      _Equipment.values.firstWhere((e) => e.name == domain.name);
}

enum _Category {
  strength,
  stretching,
  plyometrics,
  @JsonValue('powerlifting')
  powerLifting,
  @JsonValue('olympic weightlifting')
  olympicWeightlifting,
  strongman,
  cardio;

  ExCategory toDomain() => ExCategory.values.firstWhere((e) => e.name == name);
  static _Category fromDomain(ExCategory domain) =>
      _Category.values.firstWhere((e) => e.name == domain.name);
}

enum _Level {
  beginner,
  intermediate,
  expert;

  ExLevel toDomain() => ExLevel.values.firstWhere((e) => e.name == name);
  static _Level fromDomain(ExLevel domain) =>
      _Level.values.firstWhere((e) => e.name == domain.name);
}

enum _Muscle {
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

  Muscle toDomain() => Muscle.values.firstWhere((e) => e.name == name);
  static _Muscle fromDomain(Muscle domain) =>
      _Muscle.values.firstWhere((e) => e.name == domain.name);
}

enum _Force {
  pull,
  push,
  static;

  Force toDomain() => Force.values.firstWhere((e) => e.name == name);
  static _Force fromDomain(Force domain) => _Force.values.firstWhere((e) => e.name == domain.name);
}

enum _Mechanic {
  compound,
  isolation;

  Mechanic toDomain() => Mechanic.values.firstWhere((e) => e.name == name);
  static _Mechanic fromDomain(Mechanic domain) =>
      _Mechanic.values.firstWhere((e) => e.name == domain.name);
}

enum _Field {
  time,
  distance,
  weight,
  reps;

  FieldType toDomain() => FieldType.values.firstWhere((e) => e.name == name);
  static _Field fromDomain(FieldType domain) =>
      _Field.values.firstWhere((e) => e.name == domain.name);
}
