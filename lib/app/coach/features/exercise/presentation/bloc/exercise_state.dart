// ignore_for_file: avoid_redundant_argument_values

part of 'exercise_bloc.dart';

final class ExerciseState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final PaginatedResult<Exercise> exercises;
  final ExFilters filters;

  const ExerciseState._({
    required this.status,
    required this.exercises,
    required this.searchTerm,
    required this.filters,
  });

  ExerciseState._initial()
      : this._(
          searchTerm: '',
          status: const Initial(),
          exercises: const PaginatedResult(),
          filters: ExFilters(),
        );

  ExerciseState _searchInProgress(String searchTerm) => _copyWith(
        status: const Loading(),
        searchTerm: searchTerm,
      );

  ExerciseState _success({PaginatedResult<Exercise>? exercises}) => _copyWith(
        exercises: exercises,
        status: const Success(null),
      );

  ExerciseState _failure(GenericException exception) => _copyWith(status: Failure(exception));

  ExerciseState _filter(ExFilters filters) => _copyWith(filters: filters);

  ExerciseState _copyWith({
    VoidStatus? status,
    String? searchTerm,
    PaginatedResult<Exercise>? exercises,
    ExFilters? filters,
  }) {
    return ExerciseState._(
      status: status ?? this.status,
      filters: filters ?? this.filters,
      exercises: exercises ?? this.exercises,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [
        status,
        exercises,
        searchTerm,
      ];
}
