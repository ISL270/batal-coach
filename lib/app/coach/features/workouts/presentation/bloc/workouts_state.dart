part of 'workouts_bloc.dart';

final class WorkoutsState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final List<Workout> workouts;

  const WorkoutsState({
    this.status = const Initial(),
    this.searchTerm = '',
    this.workouts = const [],
  });

  WorkoutsState copyWith({
    VoidStatus? status,
    String? searchTerm,
    List<Workout>? workouts,
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
