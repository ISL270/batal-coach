// ignore_for_file: avoid_redundant_argument_values

part of 'exercise_bloc.dart';

final class ExerciseState extends Equatable {
  final Status status;
  final String searchTerm;

  /// All Exercises.
  final PaginatedResult<Exercise> exercises;

  /// Exercises returned from search result.
  final PaginatedResult<Exercise> searchResult;

  const ExerciseState._({
    required this.status,
    required this.exercises,
    required this.searchTerm,
    required this.searchResult,
  });

  const ExerciseState._initial()
      : this._(
          status: const Initial(),
          searchTerm: '',
          exercises: const PaginatedResult(),
          searchResult: const PaginatedResult(),
        );

  ExerciseState _searchInProgress(String searchTerm) => _copyWith(
        status: const Loading(),
        searchTerm: searchTerm,
      );

  ExerciseState _fetchingNextPage() => _copyWith(status: const PageLoading());

  ExerciseState _success({
    PaginatedResult<Exercise>? exercises,
    PaginatedResult<Exercise>? searchResult,
  }) =>
      _copyWith(
        status: const Success(),
        exercises: exercises,
        searchResult: searchResult,
      );

  ExerciseState _failure(GenericException exception) => _copyWith(status: Failure(exception));

  ExerciseState _copyWith({
    Status? status,
    String? searchTerm,
    PaginatedResult<Exercise>? exercises,
    PaginatedResult<Exercise>? searchResult,
  }) {
    return ExerciseState._(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      searchTerm: searchTerm ?? this.searchTerm,
      searchResult: searchResult ?? this.searchResult,
    );
  }

  @override
  List<Object?> get props => [
        status,
        exercises,
        searchTerm,
        searchResult,
      ];

  bool get hasSearchTerm => searchTerm.isNotBlank;

  List<Exercise> get displayedExercises => hasSearchTerm ? searchResult.result : exercises.result;

  bool get hasReachedMax => hasSearchTerm ? searchResult.hasReachedMax : exercises.hasReachedMax;
}
