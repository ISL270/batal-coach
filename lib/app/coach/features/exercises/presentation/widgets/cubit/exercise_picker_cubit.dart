import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exercise_picker_state.dart';

class ExercisePickerCubit extends Cubit<ExercisePickerState> {
  ExercisePickerCubit() : super(ExercisePickerInitial());
}
