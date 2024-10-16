part of 'workout_builder_cubit.dart';

final class WorkoutBuilderState extends Equatable {
  final List<Exercise> exercises;
  const WorkoutBuilderState({this.exercises = const []});

  WorkoutBuilderState copyWith({List<Exercise>? exercises}) {
    return WorkoutBuilderState(
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  List<Object> get props => [exercises];
}
