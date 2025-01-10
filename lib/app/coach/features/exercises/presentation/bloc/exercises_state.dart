// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_redundant_argument_values

part of 'exercises_bloc.dart';

final class ExercisesState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final ExcFilters filters;
  final PaginatedResult<Exercise> exercises;

  const ExercisesState._({
    required this.status,
    required this.filters,
    required this.exercises,
    required this.searchTerm,
  });

  ExercisesState._initial()
      : this._(
          searchTerm: '',
          filters: ExcFilters(),
          status: const Initial(),
          exercises: const PaginatedResult(),
        );

  ExercisesState _copyWith({
    VoidStatus? status,
    String? searchTerm,
    ExcFilters? filters,
    PaginatedResult<Exercise>? exercises,
  }) {
    return ExercisesState._(
      status: status ?? this.status,
      filters: filters ?? this.filters,
      exercises: exercises ?? this.exercises,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [
        status,
        filters,
        exercises,
        searchTerm,
      ];
}
