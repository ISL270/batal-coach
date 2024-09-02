part of 'exercise_bloc.dart';

sealed class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

final class ExercisesInitialized extends ExerciseEvent {
  String get emptySearch => '';
}

final class ExerciseSearched extends ExerciseEvent {
  final String searchTerm;
  const ExerciseSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class ExerciseNextPageFetched extends ExerciseEvent {}
