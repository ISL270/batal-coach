part of 'exercise_bloc.dart';

sealed class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

final class ExerciseInitial extends ExerciseState {}

final class ExerciseLoading extends ExerciseState {}

final class ExerciseSuccess extends ExerciseState {
  final String searchTerm;
  const ExerciseSuccess(this.searchTerm);
  @override
  List<Object> get props => [searchTerm];
}

final class ExerciseFailure extends ExerciseState {}
