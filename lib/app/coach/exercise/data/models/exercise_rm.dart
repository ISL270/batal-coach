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
}

extension ERMX on ExerciseRM {
  Exercise toDomain() => Exercise(
        id: id!,
        name: name!,
        force: force,
        level: level,
        mechanic: mechanic,
        equipment: equipment,
        primaryMuscles: primaryMuscles ?? {},
        secondaryMuscles: secondaryMuscles ?? {},
        instructions: instructions ?? [],
        category: category,
        images: images ?? {},
      );
}
