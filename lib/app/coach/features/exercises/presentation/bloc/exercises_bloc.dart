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

part 'exercises_event.dart';
part 'exercises_state.dart';

@injectable
class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final ExercisesRepository _repository;

  ExercisesBloc(this._repository) : super(ExercisesState._initial()) {
    on<_ExcsSubscriptionRequested>(_onSubscriptionRequested);
    on<ExcsSearched>(_onSearched);
    on<ExcsNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );
    on<ExcsFiltered>(_onFilterUpdate);

    add(_ExcsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _ExcsSubscriptionRequested event,
    Emitter<ExercisesState> emit,
  ) async {
    await emit.forEach(
      _repository.getUpdates(),
      onData: (status) {
        if (status.isSuccess) {
          add(ExcsSearched(state.searchTerm));
        }
        return state;
      },
    );
  }

  Future<void> _onSearched(ExcsSearched event, Emitter<ExercisesState> emit) async {
    emit(state._searchInProgress(event.searchTerm));

    final searchResult = await _repository.searchExercises(
      event.searchTerm,
      state.filters,
      page: 0,
      pageSize: state.exercises.pageSize,
    );

    emit(state._success(exercises: PaginatedResult(result: searchResult)));
  }

  Future<void> _onNextPageFetched(
    ExcsNextPageFetched event,
    Emitter<ExercisesState> emit,
  ) async {
    if (state.exercises.hasReachedMax) return;

    final searchResult = await _repository.searchExercises(
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
    ExcsFiltered event,
    Emitter<ExercisesState> emit,
  ) {
    if (state.filters == event.filters) return;
    emit(state._filter(event.filters));
    add(ExcsSearched(state.searchTerm));
  }
}
