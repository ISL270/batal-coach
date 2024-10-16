import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_details_state.dart';

class WorkoutDetailsCubit extends Cubit<WorkoutDetailsState> {
  WorkoutDetailsCubit() : super(WorkoutDetailsInitial());
}
