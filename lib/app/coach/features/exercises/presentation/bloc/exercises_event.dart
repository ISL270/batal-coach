part of 'exercises_bloc.dart';

sealed class ExercisesEvent extends Equatable {
  const ExercisesEvent();

  @override
  List<Object> get props => [];
}

final class _ExcsSubscriptionRequested extends ExercisesEvent {}

final class ExcsSearched extends ExercisesEvent {
  final String searchTerm;
  const ExcsSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class ExcsNextPageFetched extends ExercisesEvent {}

final class ExcsFiltered extends ExercisesEvent {
  final ExcFilters filters;
  const ExcsFiltered(this.filters);

  @override
  List<Object> get props => [filters];
}
