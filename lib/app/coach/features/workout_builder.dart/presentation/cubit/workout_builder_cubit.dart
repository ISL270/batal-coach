import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'workout_builder_state.dart';

class WorkoutBuilderCubit extends Cubit<WorkoutBuilderState> {
  WorkoutBuilderCubit() : super(const WorkoutBuilderState());

  final pageController = PageController();
  final TextEditingController workoutName = TextEditingController();
  final TextEditingController workoutDesc = TextEditingController();

  void addExercises(List<Exercise> exercises) {
    emit(state.copyWith(exercises: exercises.map(ExerciseDetails.new).toList(), name: workoutName.text));
  }

  void removeSet(int excIndex, SET set) {
    final updatedExc = state.exercises[excIndex].removeSet(set);
    final updatedExercises = List<ExerciseDetails>.from(state.exercises)..[excIndex] = updatedExc;
    emit(state.copyWith(exercises: updatedExercises));
  }

  void addSet(int excIndex) {
    final updatedExc = state.exercises[excIndex].addSet();
    final updatedExercises = List<ExerciseDetails>.from(state.exercises)..[excIndex] = updatedExc;
    emit(state.copyWith(exercises: updatedExercises));
  }

  void updateField<F extends Field>(int excIndex, SET set, F field) {
    final updatedExc = state.exercises[excIndex].updateField(set, field);
    final updatedExercises = List<ExerciseDetails>.from(state.exercises)..[excIndex] = updatedExc;
    emit(state.copyWith(exercises: updatedExercises));
  }

  void startOrderingExc() {
    emit(state.copyWith(reordering: true));
  }

  void finishOrderingExc() {
    emit(state.copyWith(reordering: false));
  }
}
