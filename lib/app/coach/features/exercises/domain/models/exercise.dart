import 'package:btl/app/coach/features/exercises/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercises/domain/models/field_type.dart';
import 'package:btl/app/coach/features/exercises/domain/models/force.dart';
import 'package:btl/app/coach/features/exercises/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercises/domain/models/muscle.dart';
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
