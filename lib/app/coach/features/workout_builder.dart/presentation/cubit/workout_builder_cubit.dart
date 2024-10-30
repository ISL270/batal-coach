import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/workouts/domain/workout_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/models/optional.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'workout_builder_state.dart';

class WorkoutBuilderCubit extends Cubit<WorkoutBuilderState> {
  final WorkoutRepository _workoutRepository;
  WorkoutBuilderCubit(this._workoutRepository) : super(const WorkoutBuilderState());

  final pageController = PageController();

  void updateName(String name) => emit(state.copyWith(name: name));

  void updateDescription(String description) => emit(state.copyWith(
        description: description.isBlank ? const Optional.value(null) : Optional.value(description),
      ));

  void addExercises(List<Exercise> exercises) {
    emit(state.copyWith(exercisesSets: exercises.map(ExerciseSets.new).toList()));
  }

  void removeSet(int excIndex, SET set) {
    final updatedExc = state.exercisesSets[excIndex].removeSet(set);
    final updatedExercises = List<ExerciseSets>.from(state.exercisesSets)..[excIndex] = updatedExc;
    emit(state.copyWith(exercisesSets: updatedExercises));
  }

  void addSet(int excIndex) {
    final updatedExc = state.exercisesSets[excIndex].addSet();
    final updatedExercises = List<ExerciseSets>.from(state.exercisesSets)..[excIndex] = updatedExc;
    emit(state.copyWith(exercisesSets: updatedExercises));
  }

  void updateField<F extends Field>(int excIndex, SET set, F field) {
    final updatedExc = state.exercisesSets[excIndex].updateField(set, field);
    final updatedExercises = List<ExerciseSets>.from(state.exercisesSets)..[excIndex] = updatedExc;
    emit(state.copyWith(exercisesSets: updatedExercises));
  }

  void startOrderingExc() {
    emit(state.copyWith(reordering: true));
  }

  void finishOrderingExc() {
    emit(state.copyWith(reordering: false));
  }

  Future<void> saveWorkout() async {
    emit(state.copyWith(status: const Loading()));
    final res = await _workoutRepository.saveWorkout(
      name: state.name,
      description: state.description.value,
      exercisesSets: state.exercisesSets,
    );

    res.fold(
      (e) => emit(state.copyWith(status: Failure(e))),
      (r) => emit(state.copyWith(status: Success(r))),
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
