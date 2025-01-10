import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
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
    on<ExcsFiltered>(_onFilterUpdate);
    on<ExcsNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );

    add(_ExcsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _ExcsSubscriptionRequested event,
    Emitter<ExercisesState> emit,
  ) async {
    // Listen to status updates from the repository using onEach
    // This creates a stream subscription that will react to different status changes
    await emit.onEach(
      _repository.stream(),
      onData: (status) => switch (status) {
        Loading<void>() => state.exercises.result.isEmpty
            // If no exercises are loaded yet emit loading state
            ? emit(state._copyWith(status: state.status.toLoading()))
            // If exercises already exist, do nothing
            : {},
        // If changes successfully happened in the repository, update the displayed result
        Success<void>() => add(ExcsSearched(state.searchTerm)),
        Failure<void>(exception: final e) =>
          emit(state._copyWith(status: state.status.toFailure(e))),
        _ => {},
      },
    );
  }

  Future<void> _onSearched(ExcsSearched event, Emitter<ExercisesState> emit) async {
    emit(state._copyWith(
      searchTerm: event.searchTerm,
      status: state.status.toLoading(),
    ));

    final searchResult = await _repository.searchExercises(
      event.searchTerm,
      state.filters,
      page: 0,
      pageSize: state.exercises.pageSize,
    );

    emit(state._copyWith(
      status: state.status.toSuccess(null),
      exercises: PaginatedResult(result: searchResult),
    ));
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

    emit(state._copyWith(
      status: state.status.toSuccess(null),
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
    emit(state._copyWith(filters: event.filters));
    add(ExcsSearched(state.searchTerm));
  }
}
