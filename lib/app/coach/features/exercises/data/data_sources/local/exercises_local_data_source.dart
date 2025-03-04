// import 'package:btl/app/coach/features/exercises/data/models/local/exercise_isar.dart';
// import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
// import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
// import 'package:btl/app/core/services/local_db/i_local_db.dart';

// abstract interface class ExercisesLocalDataSource {
//   final LocalDB localDB;
//   const ExercisesLocalDataSource(this.localDB);

//   Future<List<int>> updateExercises(List<Exercise> exercises);

//   Future<int> deleteExercises(List<String> ids);

//   Future<List<ExerciseIsar>> getExercises(
//     String searchTerm,
//     ExcFilters? filters,
//     int page,
//     int pageSize,
//   );

//   Future<void> clearExercises();

//   Future<List<ExerciseIsar>> getExercisesByIDs(List<String> ids);

//   Future<ExerciseIsar?> getExercise(String id);
// }
