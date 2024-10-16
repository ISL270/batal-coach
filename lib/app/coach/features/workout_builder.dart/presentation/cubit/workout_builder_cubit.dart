import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'workout_builder_state.dart';

class WorkoutBuilderCubit extends Cubit<WorkoutBuilderState> {
  WorkoutBuilderCubit() : super(const WorkoutBuilderState());

  final pageController = PageController();

  void addExercises(List<Exercise> exercises) {
    final newExercises = List<Exercise>.from(state.exercises)..addAll(exercises);
    emit(state.copyWith(exercises: newExercises));
  }
}
