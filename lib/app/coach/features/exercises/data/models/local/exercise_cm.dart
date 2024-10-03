import 'package:btl/app/coach/features/exercises/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercises/domain/models/force.dart';
import 'package:btl/app/coach/features/exercises/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercises/domain/models/muscle.dart';
import 'package:btl/app/core/models/cache_model.dart';

abstract interface class ExerciseCM extends CacheModel<Exercise> {
  final String id;
  final String name;
  final Force? force;
  final ExLevel? level;
  final Mechanic? mechanic;
  final ExCategory? category;
  final Equipment? equipment;
  final List<String> instructions;
  final List<String> images;
  final Muscle mainMuscle;
  final List<Muscle> secondaryMuscles;

  ExerciseCM({
    required this.id,
    required this.name,
    required this.instructions,
    required this.images,
    required this.mainMuscle,
    required this.secondaryMuscles,
    this.force,
    this.level,
    this.mechanic,
    this.category,
    this.equipment,
  });
}
