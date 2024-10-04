import 'package:btl/app/coach/features/exercises/data/models/local/exercise_cm.dart';
import 'package:btl/app/coach/features/exercises/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercises/domain/models/field_type.dart';
import 'package:btl/app/coach/features/exercises/domain/models/force.dart';
import 'package:btl/app/coach/features/exercises/domain/models/mechanic.dart';
import 'package:btl/app/coach/features/exercises/domain/models/muscle.dart';
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

  @Enumerated(EnumType.name)
  List<FieldType> fields;

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
    required this.fields,
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
        fields: fields,
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
        fields: exc.fields,
      );
}

// enum _Field {
//   time,
//   distance,
//   weight,
//   reps;

//   Field toDomain() {
//     return switch (this) {
//       _Field.time => Time.zero(),
//       _Field.distance => Distance.zero(),
//       _Field.weight => Weight.zero(),
//       _Field.reps => Reps.zero(),
//     };
//   }

//   static _Field fromDomain(Field field) {
//     return switch (field) {
//       Time() => _Field.time,
//       Distance() => _Field.distance,
//       Weight() => _Field.weight,
//       Reps() => _Field.reps,
//     };
//   }
// }

