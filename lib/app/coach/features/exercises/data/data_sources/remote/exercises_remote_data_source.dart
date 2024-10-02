import 'package:btl/app/coach/features/exercises/data/models/remote/exercise_rm.dart';

abstract interface class ExercisesRemoteDataSource {
  Stream<List<ExerciseRM>> get excsToBeUpdated;

  void subToRemote();

  Future<void> cancelRemoteSub();

  void dispose();
}
