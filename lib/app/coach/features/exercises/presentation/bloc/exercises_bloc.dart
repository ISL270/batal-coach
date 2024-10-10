import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/domain/paginated_result.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

@injectable
class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final ExercisesRepository _repository;

  ExercisesBloc(this._repository) : super(ExercisesState._initial()) {
    on<ExSearched>(_onSearched);
    on<ExNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );
    on<ExFiltered>(_onFilterUpdate);

    add(const ExSearched(''));
  }

  Future<void> _onSearched(ExSearched event, Emitter<ExercisesState> emit) async {
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
    ExNextPageFetched event,
    Emitter<ExercisesState> emit,
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
    ExFiltered event,
    Emitter<ExercisesState> emit,
  ) {
    if (state.filters == event.filters) return;
    emit(state._filter(event.filters));
    add(ExSearched(state.searchTerm));
  }
}
