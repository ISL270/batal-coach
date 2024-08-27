part of 'exercise_bloc.dart';

final class ExerciseState extends Equatable {
  final Status status;
  final String searchTerm;
  final Set<Exercise> exercises;
  final Set<Exercise> searchResult;
  final GenericException? exception;

  const ExerciseState._({
    required this.status,
    required this.searchTerm,
    required this.exercises,
    required this.searchResult,
    required this.exception,
  });

  const ExerciseState._initial()
      : this._(
          status: Status.initial,
          searchTerm: '',
          exception: null,
          exercises: const {},
          searchResult: const {},
        );

  ExerciseState _searchInProgress(String searchTerm) => _copyWith(
        status: Status.loading,
        searchTerm: searchTerm,
      );

  ExerciseState _success({Set<Exercise>? exercises, Set<Exercise>? searchResult}) => _copyWith(
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
    Set<Exercise>? exercises,
    Set<Exercise>? searchResult,
    GenericException? exception,
  }) {
    return ExerciseState._(
      status: status ?? this.status,
      searchTerm: searchTerm ?? this.searchTerm,
      exercises: exercises ?? this.exercises,
      searchResult: searchResult ?? this.searchResult,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [
        status,
        exercises,
        searchTerm,
        searchResult,
        exception,
      ];

  Set<Exercise> get displayedExercises => searchTerm.isBlank ? exercises : searchResult;
}
