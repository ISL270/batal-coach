part of 'exercise_details_cubit.dart';

sealed class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState();

  @override
  List<Object> get props => [];
}

final class ExerciseDetailsInitial extends ExerciseDetailsState {}
