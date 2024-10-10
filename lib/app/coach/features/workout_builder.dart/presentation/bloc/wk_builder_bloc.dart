import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:equatable/equatable.dart';

part 'wk_builder_event.dart';
part 'wk_builder_state.dart';

class WkBuilderBloc extends Bloc<WkBuilderEvent, WkBuilderState> {
  final ExercisesRepository _repository;

  WkBuilderBloc(this._repository) : super(const WkBuilderState()) {
    on<WkBuilderInitial>(onInitial);
    add(const WkBuilderInitial());
  }

  Future<void> onInitial(WkBuilderInitial event, Emitter<WkBuilderState> emit) async {
    emit(state.copyWith(status: const Loading()));
    final excs = await _repository.getExcsByIDs(['Kettlebell_Seated_Press', 'Walking_Treadmill']);
    emit(state.copyWith(status: const Success(null), exercises: excs));
  }
}
