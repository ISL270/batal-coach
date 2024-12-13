import 'package:btl/app/core/models/domain/field.dart';
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String name;
  final Force? force;
  final ExType? type;
  final ExLevel? level;
  final Muscle mainMuscle;
  final Mechanic? mechanic;
  final List<String> images;
  final Equipment? equipment;
  final List<FieldType> fieldTypes;
  final List<String> instructions;
  final List<Muscle> secondaryMuscles;

  const Exercise({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.images,
    required this.fieldTypes,
    required this.mechanic,
    required this.type,
    required this.equipment,
    required this.mainMuscle,
    required this.instructions,
    required this.secondaryMuscles,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        force,
        level,
        images,
        fieldTypes,
        mechanic,
        equipment,
        mainMuscle,
        instructions,
        secondaryMuscles,
      ];
}

extension ExerciseX on Exercise {
  List<Field> initialFields() {
    return fieldTypes
        .map((f) => switch (f) {
              FieldType.time => Time.zero(),
              FieldType.distance => Distance.zero(),
              FieldType.weight => Weight.zero(),
              FieldType.reps => Reps.zero(),
            })
        .toList();
  }

  String get mockImage =>
      'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2Fweighted_crunches.gif?alt=media&token=b17224d9-6542-4292-b600-fd9949a7f913';
}

enum ExType {
  strength,
  bodyWeight,
  timed,
  distance,
}

enum ExOwnership { btl, personal }

enum ExLevel {
  beginner,
  intermediate,
  expert,
}

enum Equipment {
  barbell,
  dumbbell,
  cable,
  machine,
  kettlebells,
  bands,
  medicineBall,
  exerciseBall,
  foamRoll,
  ezCurlBar,
  bodyOnly,
  other,
}

enum FieldType { time, distance, weight, reps }

enum Force { pull, push, static }

enum Mechanic { compound, isolation }

enum Muscle {
  quadriceps,
  shoulders,
  abdominals,
  chest,
  hamstrings,
  triceps,
  biceps,
  lats,
  middleBack,
  calves,
  lowerBack,
  forearms,
  glutes,
  traps,
  adductors,
  abductors,
  neck,
}
