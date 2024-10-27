import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/optional.dart';
import 'package:btl/app/core/models/workout/domain/exercise_details.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'workout_builder_state.dart';

class WorkoutBuilderCubit extends Cubit<WorkoutBuilderState> {
  WorkoutBuilderCubit() : super(const WorkoutBuilderState());

  final pageController = PageController();

  void updateName(String name) => emit(state.copyWith(name: name));

  void updateDescription(String description) => emit(state.copyWith(
        description: description.isBlank ? const Optional.value(null) : Optional.value(description),
      ));

  void addExercises(List<Exercise> exercises) {
    emit(state.copyWith(exercises: exercises.map(ExerciseDetails.new).toList()));
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

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
