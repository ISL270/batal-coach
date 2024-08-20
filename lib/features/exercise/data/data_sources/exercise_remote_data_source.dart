import 'package:btl/features/exercise/data/models/exercise_rm.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<Iterable<ExerciseRM>> getExercises();
}
