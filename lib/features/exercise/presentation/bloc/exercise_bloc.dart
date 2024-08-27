import 'package:bloc/bloc.dart';
import 'package:btl/core/blocs/bloc_event_transformers.dart';
import 'package:btl/core/enums/status.dart';
import 'package:btl/core/generic_exception.dart';
import 'package:btl/features/exercise/data/repositories/exercise_repository.dart';
import 'package:btl/features/exercise/domain/models/exercise.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository _repository;

  ExerciseBloc(this._repository) : super(const ExerciseState._initial()) {
    on<ExercisesInitialized>(_onInitialized);
    on<ExerciseSearched>(_onSearched, transformer: EvenTransformers.debounceRestartable());
    add(const ExercisesInitialized());
  }

  Future<void> _onInitialized(ExercisesInitialized event, Emitter<ExerciseState> emit) async {
    emit(state._searchInProgress(event.emptySearch));
    if (state.exercises.isNotEmpty) {
      emit(state._success());
      return;
    }
    final response = await _repository.getExercises(event.emptySearch);
    response.fold(
      (exc) => emit(state._failure(exc)),
      (resultExercises) => emit(state._success(exercises: resultExercises.toSet())),
    );
  }

  Future<void> _onSearched(ExerciseSearched event, Emitter<ExerciseState> emit) async {
    if (event.searchTerm.isBlank) {
      add(const ExercisesInitialized());
      return;
    }
    if (event.searchTerm == state.searchTerm) return;
    emit(state._searchInProgress(event.searchTerm));
    final response = await _repository.getExercises(event.searchTerm);
    response.fold(
      (exc) => emit(state._failure(exc)),
      (resultExercises) => emit(state._success(searchResult: resultExercises.toSet())),
    );
  }
}
