import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/exercise/data/repositories/exercise_repository.dart';
import 'package:btl/app/coach/exercise/domain/models/exercise.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/models/paginated_result.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

@injectable
class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository _repository;

  ExerciseBloc(this._repository) : super(const ExerciseState._initial()) {
    on<ExercisesInitialized>(_onInitialized);
    on<ExerciseSearched>(
      _onSearched,
      transformer: EventTransformers.debounceRestartable(),
    );
    on<ExerciseNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );
    add(ExercisesInitialized());
  }

  Future<void> _onInitialized(ExercisesInitialized event, Emitter<ExerciseState> emit) async {
    emit(state._searchInProgress(event.emptySearch));
    if (state.exercises.result.isNotEmpty) {
      emit(state._success());
      return;
    }
    final response = await _repository.getExercises(searchTerm: event.emptySearch, page: 0);
    response.fold(
      (exc) => emit(state._failure(exc)),
      (resultExercises) => emit(state._success(
        exercises: PaginatedResult(result: resultExercises.toList()),
      )),
    );
  }

  Future<void> _onSearched(ExerciseSearched event, Emitter<ExerciseState> emit) async {
    if (event.searchTerm.isBlank) {
      add(ExercisesInitialized());
      return;
    }
    if (event.searchTerm == state.searchTerm) return;
    emit(state._searchInProgress(event.searchTerm));
    final response = await _repository.getExercises(searchTerm: event.searchTerm, page: 0);
    response.fold(
      (exc) => emit(state._failure(exc)),
      (resultExercises) => emit(state._success(
        searchResult: PaginatedResult(result: resultExercises.toList()),
      )),
    );
  }

  Future<void> _onNextPageFetched(
    ExerciseNextPageFetched event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state._fetchingNextPage());

    final response = await _repository.getExercises(
      searchTerm: state.searchTerm,
      page: (state.hasSearchTerm ? state.searchResult.page : state.exercises.page) + 1,
    );

    response.fold(
      (exc) => emit(state._failure(exc)),
      (resultExercises) {
        if (state.hasSearchTerm) {
          emit(state._success(
            searchResult: state.searchResult.appendResult(
              resultExercises,
              hasReachedMax: resultExercises.length < _repository.pageSize,
            ),
          ));
          return;
        }
        emit(state._success(
          exercises: state.exercises.appendResult(
            resultExercises,
            hasReachedMax: resultExercises.length < _repository.pageSize,
          ),
        ));
      },
    );
  }
}
