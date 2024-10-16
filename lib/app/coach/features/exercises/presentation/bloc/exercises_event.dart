part of 'exercises_bloc.dart';

sealed class ExercisesEvent extends Equatable {
  const ExercisesEvent();

  @override
  List<Object> get props => [];
}

final class ExcSearched extends ExercisesEvent {
  final String searchTerm;
  const ExcSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class ExcNextPageFetched extends ExercisesEvent {}

final class ExcFiltered extends ExercisesEvent {
  final ExcFilters filters;
  const ExcFiltered(this.filters);

  @override
  List<Object> get props => [filters];
}
