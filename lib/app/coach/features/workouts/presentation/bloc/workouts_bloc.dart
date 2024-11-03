import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/workouts/domain/workout_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:equatable/equatable.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final WorkoutRepository _workoutRepository;

  WorkoutsBloc(this._workoutRepository) : super(const WorkoutsState()) {
    on<_WorkoutsSubscriptionRequested>(_onSubscriptionRequested);
    add(_WorkoutsSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _WorkoutsSubscriptionRequested event,
    Emitter<WorkoutsState> emit,
  ) async {
    // await emit.forEach(
    //   _workoutRepository.getUpdates(),
    //   onData: (workouts) => state.copyWith(workouts: workouts),
    // );
  }
}
