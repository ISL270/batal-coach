import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial()) {
    on<WorkoutsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
