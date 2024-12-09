import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/extension_methods/string_x.dart';
import 'package:btl/app/core/models/cache_model.dart';
import 'package:isar/isar.dart';

part 'exercise_isar.g.dart';

@collection
final class ExerciseIsar implements CacheModel<Exercise> {
  @override
  Id get cacheID => id.fastHash;

  String id;

  @Index(type: IndexType.value, caseSensitive: false)
  String name;

  @Enumerated(EnumType.name)
  Force? force;

  @Enumerated(EnumType.name)
  ExLevel? level;

  @Enumerated(EnumType.name)
  Mechanic? mechanic;

  @Enumerated(EnumType.name)
  ExType? type;

  @Enumerated(EnumType.name)
  Equipment? equipment;

  @Enumerated(EnumType.name)
  Muscle mainMuscle;

  List<String> instructions;

  List<String> images;

  @Enumerated(EnumType.name)
  List<Muscle> secondaryMuscles;

  @Enumerated(EnumType.name)
  List<FieldType> fields;

  ExerciseIsar({
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
}
