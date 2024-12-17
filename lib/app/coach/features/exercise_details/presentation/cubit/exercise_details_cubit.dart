import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exercise_details_state.dart';

class ExerciseDetailsCubit extends Cubit<ExerciseDetailsState> {
  ExerciseDetailsCubit() : super(ExerciseDetailsInitial());
}
