import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/force.dart';
import 'package:btl/app/coach/features/exercise/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';

class Exercise {
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

  Exercise({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.category,
    required this.equipment,
    required this.instructions,
    required this.images,
    required this.mainMuscle,
    required this.secondaryMuscles,
  });
}
