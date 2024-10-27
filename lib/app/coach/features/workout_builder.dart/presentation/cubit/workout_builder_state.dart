part of 'workout_builder_cubit.dart';

final class WorkoutBuilderState extends Equatable {
  final String name;
  final Optional<String> description;
  final bool reordering;
  final List<ExerciseDetails> exercises;

  const WorkoutBuilderState({
    this.exercises = const [],
    this.name = '',
    this.description = const Optional.absent(),
    this.reordering = false,
  });

  WorkoutBuilderState copyWith({
    List<ExerciseDetails>? exercises,
    String? name,
    Optional<String>? description,
    bool? reordering,
  }) {
    return WorkoutBuilderState(
      exercises: exercises ?? this.exercises,
      name: name ?? this.name,
      description: description ?? this.description,
      reordering: reordering ?? this.reordering,
    );
  }

  @override
  List<Object?> get props => [exercises, reordering, name, description];
}
