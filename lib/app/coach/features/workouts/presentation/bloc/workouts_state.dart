part of 'workouts_bloc.dart';

final class WorkoutsState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final PaginatedResult<Workout> workouts;

  const WorkoutsState({
    this.searchTerm = '',
    this.status = const Initial(),
    this.workouts = const PaginatedResult(),
  });

  WorkoutsState copyWith({
    VoidStatus? status,
    String? searchTerm,
    PaginatedResult<Workout>? workouts,
  }) {
    return WorkoutsState(
      status: status ?? this.status,
      workouts: workouts ?? this.workouts,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object> get props => [status, searchTerm, workouts];
}
