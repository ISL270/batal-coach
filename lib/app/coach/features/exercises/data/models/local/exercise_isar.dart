import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/isar/cache_model.dart';
import 'package:isar/isar.dart';

part 'exercise_isar.g.dart';

@collection
final class ExerciseIsar extends CacheModel<Exercise> {
  @override
  final String id;

  @Index(type: IndexType.value, caseSensitive: false)
  final String name;

  @Enumerated(EnumType.name)
  final Force? force;

  @Enumerated(EnumType.name)
  final ExLevel? level;

  @Enumerated(EnumType.name)
  final Mechanic? mechanic;

  @Enumerated(EnumType.name)
  final ExType? type;

  @Enumerated(EnumType.name)
  final Equipment? equipment;

  @Enumerated(EnumType.name)
  final Muscle mainMuscle;

  final List<String> instructions;

  final List<String> images;

  @Enumerated(EnumType.name)
  final List<Muscle> secondaryMuscles;

  @Enumerated(EnumType.name)
  final List<FieldType> fields;

  const ExerciseIsar({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.type,
    required this.equipment,
    required this.mainMuscle,
    required this.instructions,
    required this.images,
    required this.secondaryMuscles,
    required this.fields,
  });

  factory ExerciseIsar.fromDomain(Exercise exc) => ExerciseIsar(
        id: exc.id,
        type: exc.type,
        equipment: exc.equipment,
        force: exc.force,
        images: exc.images,
        instructions: exc.instructions,
        level: exc.level,
        mainMuscle: exc.mainMuscle,
        mechanic: exc.mechanic,
        name: exc.name,
        secondaryMuscles: exc.secondaryMuscles,
        fields: exc.fieldTypes,
      );

  @override
  Exercise toDomain() => Exercise(
        id: id,
        name: name,
        force: force,
        level: level,
        mechanic: mechanic,
        type: type,
        equipment: equipment,
        instructions: instructions,
        images: images,
        mainMuscle: mainMuscle,
        secondaryMuscles: secondaryMuscles,
        fieldTypes: fields,
      );
}
