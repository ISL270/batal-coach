import 'package:btl/app/coach/features/exercise/data/models/local/exercise_cm.dart';
import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/force.dart';
import 'package:btl/app/coach/features/exercise/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';
import 'package:btl/app/core/extensions/string_x.dart';
import 'package:isar/isar.dart';

part 'exercise_isar.g.dart';

@collection
final class ExerciseIsar implements ExerciseCM {
  @override
  Id get cacheID => id.fastHash;

  @override
  String id;

  @override
  @Index(type: IndexType.value, caseSensitive: false)
  String name;

  // @Index(type: IndexType.value, caseSensitive: false)
  // List<String> get nameWords => Isar.splitWords(name);

  @override
  @Enumerated(EnumType.name)
  Force? force;

  @override
  @Enumerated(EnumType.name)
  ExLevel? level;

  @override
  @Enumerated(EnumType.name)
  Mechanic? mechanic;

  @override
  @Enumerated(EnumType.name)
  ExCategory? category;

  @override
  @Enumerated(EnumType.name)
  Equipment? equipment;

  @override
  @Enumerated(EnumType.name)
  Muscle mainMuscle;

  @override
  List<String> instructions;

  @override
  List<String> images;

  @override
  @Enumerated(EnumType.name)
  List<Muscle> secondaryMuscles;

  ExerciseIsar({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.category,
    required this.equipment,
    required this.mainMuscle,
    required this.instructions,
    required this.images,
    required this.secondaryMuscles,
  });

  @override
  Exercise toDomain() => Exercise(
        id: id,
        name: name,
        force: force,
        level: level,
        mechanic: mechanic,
        category: category,
        equipment: equipment,
        instructions: instructions,
        images: images,
        mainMuscle: mainMuscle,
        secondaryMuscles: secondaryMuscles,
      );

  factory ExerciseIsar.fromDomain(Exercise exc) => ExerciseIsar(
        id: exc.id,
        category: exc.category,
        equipment: exc.equipment,
        force: exc.force,
        images: exc.images,
        instructions: exc.instructions,
        level: exc.level,
        mainMuscle: exc.mainMuscle,
        mechanic: exc.mechanic,
        name: exc.name,
        secondaryMuscles: exc.secondaryMuscles,
      );
}
