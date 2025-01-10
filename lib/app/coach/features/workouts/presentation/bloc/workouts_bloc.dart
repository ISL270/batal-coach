import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/workouts/domain/workout_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/bloc_event_transformers.dart';
import 'package:btl/app/core/models/domain/paginated_result.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:equatable/equatable.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final WorkoutRepository _repository;

  WorkoutsBloc(this._repository) : super(const WorkoutsState()) {
    on<_WkSubscriptionRequested>(_onSubscriptionRequested);
    on<WkSearched>(_onSearched);
    on<WkNextPageFetched>(
      _onNextPageFetched,
      transformer: EventTransformers.throttleDroppable(),
    );

    add(_WkSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _WkSubscriptionRequested event,
    Emitter<WorkoutsState> emit,
  ) async {
    await emit.forEach(
      _repository.stream(),
      onData: (status) {
        if (status.isSuccess) {
          add(WkSearched(state.searchTerm));
        }
        return state;
      },
    );
  }

  Future<void> _onSearched(WkSearched event, Emitter<WorkoutsState> emit) async {
    emit(state.copyWith(
      status: const Loading(),
      searchTerm: event.searchTerm,
    ));

    final searchResult = await _repository.searchWorkouts(
      page: 0,
      event.searchTerm,
      pageSize: state.workouts.pageSize,
    );

    emit(state.copyWith(
      status: const Success(null),
      workouts: PaginatedResult(result: searchResult),
    ));
  }

  Future<void> _onNextPageFetched(
    WkNextPageFetched event,
    Emitter<WorkoutsState> emit,
  ) async {
    if (state.workouts.hasReachedMax) return;

    final searchResult = await _repository.searchWorkouts(
      state.searchTerm,
      page: state.workouts.page + 1,
      pageSize: state.workouts.pageSize,
    );

    emit(state.copyWith(
      status: const Success(null),
      workouts: state.workouts.appendResult(
        searchResult,
        hasReachedMax: searchResult.length < state.workouts.pageSize,
      ),
    ));
  }
}
