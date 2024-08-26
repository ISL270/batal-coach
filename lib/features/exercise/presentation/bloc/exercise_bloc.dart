import 'package:bloc/bloc.dart';
import 'package:btl/core/blocs/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial()) {
    on<ExerciseSearched>(_onSearched, transformer: EvenTransformers.debounceRestartable());
  }

  void _onSearched(ExerciseSearched event, Emitter<ExerciseState> emit) {
    emit(ExerciseSuccess(event.searchTerm));
  }
}
