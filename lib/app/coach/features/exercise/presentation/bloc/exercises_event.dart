part of 'exercises_bloc.dart';

sealed class ExercisesEvent extends Equatable {
  const ExercisesEvent();

  @override
  List<Object> get props => [];
}

final class ExSearched extends ExercisesEvent {
  final String searchTerm;
  const ExSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class ExNextPageFetched extends ExercisesEvent {}

final class ExFiltered extends ExercisesEvent {
  final ExFilters filters;
  const ExFiltered(this.filters);

  @override
  List<Object> get props => [filters];
}
