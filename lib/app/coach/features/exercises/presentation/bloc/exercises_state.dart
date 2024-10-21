// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_redundant_argument_values

part of 'exercises_bloc.dart';

final class ExercisesState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final PaginatedResult<Exercise> exercises;
  final ExcFilters filters;

  const ExercisesState._({
    required this.status,
    required this.exercises,
    required this.searchTerm,
    required this.filters,
  });

  ExercisesState._initial()
      : this._(
          searchTerm: '',
          status: const Initial(),
          exercises: const PaginatedResult(),
          filters: ExcFilters(),
        );

  ExercisesState _searchInProgress(String searchTerm) => _copyWith(
        status: const Loading(),
        searchTerm: searchTerm,
      );

  ExercisesState _success({PaginatedResult<Exercise>? exercises}) => _copyWith(
        exercises: exercises,
        status: const Success(null),
      );

  // ignore: unused_element
  ExercisesState _failure(GenericException exception) => _copyWith(status: Failure(exception));

  ExercisesState _filter(ExcFilters filters) => _copyWith(filters: filters);

  ExercisesState _copyWith({
    VoidStatus? status,
    String? searchTerm,
    PaginatedResult<Exercise>? exercises,
    ExcFilters? filters,
  }) {
    const ex = Example(
      nonNullable: 'A string',
      nullable: 'Another string',
    );

    ex.copyWith(nullable: null);
    print(ex.nullable); //Another string
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
        exercises,
        searchTerm,
        filters,
      ];
}

class Example {
  final String nonNullable;
  final String? nullable;

  const Example({
    required this.nonNullable,
    this.nullable,
  });

  Example copyWith({
    String? nonNullable,
    String? nullable,
  }) {
    return Example(
      nonNullable: nonNullable ?? this.nonNullable,
      nullable: nullable ?? this.nullable,
    );
  }
}
