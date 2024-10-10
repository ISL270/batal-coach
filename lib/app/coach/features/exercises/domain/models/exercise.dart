import 'package:btl/app/coach/features/exercises/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercises/domain/models/field_type.dart';
import 'package:btl/app/coach/features/exercises/domain/models/force.dart';
import 'package:btl/app/coach/features/exercises/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercises/domain/models/muscle.dart';
import 'package:btl/app/core/models/field.dart';
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String name;
  final Force? force;
  final ExLevel? level;
  final Muscle mainMuscle;
  final Mechanic? mechanic;
  final List<String> images;
  final ExCategory? category;
  final Equipment? equipment;
  final List<FieldType> fields;
  final List<String> instructions;
  final List<Muscle> secondaryMuscles;

  const Exercise({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.images,
    required this.fields,
    required this.mechanic,
    required this.category,
    required this.equipment,
    required this.mainMuscle,
    required this.instructions,
    required this.secondaryMuscles,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        force,
        level,
        images,
        fields,
        mechanic,
        category,
        equipment,
        mainMuscle,
        instructions,
        secondaryMuscles,
      ];
}

extension ExerciseX on Exercise {
  List<Field> initialFields() {
    return fields
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
