// ignore_for_file: avoid_redundant_argument_values

part of 'exercise_bloc.dart';

final class ExerciseState extends Equatable {
  final Status status;
  final String searchTerm;
  final GenericException? exception;

  /// All Exercises.
  final PaginatedResult<Exercise> exercises;

  /// Exercises returned from search result.
  final PaginatedResult<Exercise> searchResult;

  const ExerciseState._({
    required this.status,
    required this.exercises,
    required this.exception,
    required this.searchTerm,
    required this.searchResult,
  });

  const ExerciseState._initial()
      : this._(
          status: Status.initial,
          searchTerm: '',
          exception: null,
          exercises: const PaginatedResult(),
          searchResult: const PaginatedResult(),
        );

  ExerciseState _searchInProgress(String searchTerm) => _copyWith(
        status: Status.loading,
        searchTerm: searchTerm,
        exception: null,
      );

  ExerciseState _fetchingNextPage() => _copyWith(
        status: Status.pageLoading,
        exception: null,
      );

  ExerciseState _success({
    PaginatedResult<Exercise>? exercises,
    PaginatedResult<Exercise>? searchResult,
  }) =>
      _copyWith(
        status: Status.success,
        exercises: exercises,
        searchResult: searchResult,
      );

  ExerciseState _failure(GenericException exception) => _copyWith(
        status: Status.failure,
        exception: exception,
      );

  ExerciseState _copyWith({
    Status? status,
    String? searchTerm,
    GenericException? exception,
    PaginatedResult<Exercise>? exercises,
    PaginatedResult<Exercise>? searchResult,
  }) {
    return ExerciseState._(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      exercises: exercises ?? this.exercises,
      searchTerm: searchTerm ?? this.searchTerm,
      searchResult: searchResult ?? this.searchResult,
    );
  }

  @override
  List<Object?> get props => [
        status,
        exercises,
        exception,
        searchTerm,
        searchResult,
      ];

  bool get hasSearchTerm => searchTerm.isNotBlank;

  List<Exercise> get displayedExercises => hasSearchTerm ? searchResult.result : exercises.result;

  bool get hasReachedMax => hasSearchTerm ? searchResult.hasReachedMax : exercises.hasReachedMax;
}
