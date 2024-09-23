import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';

abstract interface class ExerciseRM {
  final String id;
  final String name;
  final List<String>? instructions;
  final List<String>? images;

  const ExerciseRM(
    this.id,
    this.name,
    this.instructions,
    this.images,
  );

  Exercise toDomain();
}
