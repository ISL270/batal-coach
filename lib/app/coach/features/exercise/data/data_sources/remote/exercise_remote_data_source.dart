import 'package:btl/app/coach/features/exercise/data/models/remote/exercise_rm.dart';

abstract interface class ExerciseRemoteDataSource {
  Stream<List<ExerciseRM>> get excsToBeUpdated;

  void subToRemote();

  Future<void> cancelRemoteSub();

  void dispose();
}
