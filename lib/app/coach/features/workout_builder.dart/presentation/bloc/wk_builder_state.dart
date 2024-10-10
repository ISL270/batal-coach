part of 'wk_builder_bloc.dart';

final class WkBuilderState extends Equatable {
  final VoidStatus status;
  final List<Exercise> exercises;

  const WkBuilderState({
    this.exercises = const [],
    this.status = const Initial(),
  });

  @override
  List<Object> get props => [exercises, status];

  WkBuilderState copyWith({
    VoidStatus? status,
    List<Exercise>? exercises,
  }) {
    return WkBuilderState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
    );
  }
}
