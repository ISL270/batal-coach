import 'package:btl/app/coach/exercise/domain/models/exercise.dart';

abstract interface class ExerciseRM {
  final String? id;
  final String? name;
  final String? force;
  final String? level;
  final String? mechanic;
  final String? equipment;
  final Set<String>? primaryMuscles;
  final Set<String>? secondaryMuscles;
  final List<String>? instructions;
  final String? category;
  final Set<String>? images;

  const ExerciseRM(
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

  Exercise toDomain();
}
