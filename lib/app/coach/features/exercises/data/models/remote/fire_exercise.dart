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

  const _FireExercise(
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
        secondaryMuscles: (secondaryMuscles ?? []).map((e) => e.toDomain()).toList(),
        instructions: instructions ?? [],
        category: category?.toDomain(),
        images: images ?? [],
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

  Equipment toDomain() => switch (this) {
        _Equipment.barbell => Equipment.barbell,
        _Equipment.dumbbell => Equipment.dumbbell,
        _Equipment.cable => Equipment.cable,
        _Equipment.machine => Equipment.machine,
        _Equipment.kettlebells => Equipment.kettlebells,
        _Equipment.bands => Equipment.bands,
        _Equipment.medicineBall => Equipment.medicineBall,
        _Equipment.exerciseBall => Equipment.exerciseBall,
        _Equipment.foamRoll => Equipment.foamRoll,
        _Equipment.ezCurlBar => Equipment.ezCurlBar,
        _Equipment.bodyOnly => Equipment.bodyOnly,
        _Equipment.other => Equipment.other,
      };

  static _Equipment fromDomain(Equipment e) => switch (e) {
        Equipment.barbell => _Equipment.barbell,
        Equipment.dumbbell => _Equipment.dumbbell,
        Equipment.cable => _Equipment.cable,
        Equipment.machine => _Equipment.machine,
        Equipment.kettlebells => _Equipment.kettlebells,
        Equipment.bands => _Equipment.bands,
        Equipment.medicineBall => _Equipment.medicineBall,
        Equipment.exerciseBall => _Equipment.exerciseBall,
        Equipment.foamRoll => _Equipment.foamRoll,
        Equipment.ezCurlBar => _Equipment.ezCurlBar,
        Equipment.bodyOnly => _Equipment.bodyOnly,
        Equipment.other => _Equipment.other,
      };
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

  ExCategory toDomain() => switch (this) {
        _Category.strength => ExCategory.strength,
        _Category.stretching => ExCategory.stretching,
        _Category.plyometrics => ExCategory.plyometrics,
        _Category.powerLifting => ExCategory.powerLifting,
        _Category.olympicWeightlifting => ExCategory.olympicWeightlifting,
        _Category.strongman => ExCategory.strongman,
        _Category.cardio => ExCategory.cardio,
      };
}

enum _Level {
  beginner,
  intermediate,
  expert;

  ExLevel toDomain() => switch (this) {
        _Level.beginner => ExLevel.beginner,
        _Level.intermediate => ExLevel.intermediate,
        _Level.expert => ExLevel.expert,
      };
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

  Muscle toDomain() => switch (this) {
        _Muscle.quadriceps => Muscle.quadriceps,
        _Muscle.shoulders => Muscle.shoulders,
        _Muscle.abdominals => Muscle.abdominals,
        _Muscle.chest => Muscle.chest,
        _Muscle.hamstrings => Muscle.hamstrings,
        _Muscle.triceps => Muscle.triceps,
        _Muscle.biceps => Muscle.biceps,
        _Muscle.lats => Muscle.lats,
        _Muscle.middleBack => Muscle.middleBack,
        _Muscle.calves => Muscle.calves,
        _Muscle.lowerBack => Muscle.lowerBack,
        _Muscle.forearms => Muscle.forearms,
        _Muscle.glutes => Muscle.glutes,
        _Muscle.traps => Muscle.traps,
        _Muscle.adductors => Muscle.adductors,
        _Muscle.abductors => Muscle.abductors,
        _Muscle.neck => Muscle.neck,
      };
}

enum _Force {
  pull,
  push,
  static;

  Force toDomain() => switch (this) {
        _Force.pull => Force.pull,
        _Force.push => Force.push,
        _Force.static => Force.static,
      };
}

enum _Mechanic {
  compound,
  isolation;

  Mechanic toDomain() => switch (this) {
        _Mechanic.compound => Mechanic.compound,
        _Mechanic.isolation => Mechanic.isolation,
      };
}
