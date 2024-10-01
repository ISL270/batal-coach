import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:btl/app/coach/features/exercise/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/models/paginated_result.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

@injectable
class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository _repository;

  ExerciseBloc(this._repository) : super(ExerciseState._initial()) {
    on<ExerciseSearched>(_onSearched);
    on<ExerciseNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );
    on<ExerciseFilter>(_onFilterUpdate);

    add(const ExerciseSearched(''));
  }

  Future<void> _onSearched(ExerciseSearched event, Emitter<ExerciseState> emit) async {
    emit(state._searchInProgress(event.searchTerm));

    await _repository
        .getUpdates()
        .takeWhileInclusive((status) => !status.isSuccess)
        .last
        .whenComplete(() async {
      final searchResult = await _repository.getExercises(
        page: 0,
        event.searchTerm,
        state.filters,
        pageSize: state.exercises.pageSize,
      );
      emit(state._success(exercises: PaginatedResult(result: searchResult)));
    });
    //TODO: catch errors
  }

  Future<void> _onNextPageFetched(
    ExerciseNextPageFetched event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state.exercises.hasReachedMax) return;

    final searchResult = await _repository.getExercises(
      state.searchTerm,
      state.filters,
      page: state.exercises.page + 1,
      pageSize: state.exercises.pageSize,
    );

    emit(state._success(
      exercises: state.exercises.appendResult(
        searchResult,
        hasReachedMax: searchResult.length < state.exercises.pageSize,
      ),
    ));
  }

  void _onFilterUpdate(
    ExerciseFilter event,
    Emitter<ExerciseState> emit,
  ) {
    emit(state._filter(event.filters));
    add(ExerciseSearched(state.searchTerm));
  }
}
