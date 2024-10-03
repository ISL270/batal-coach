import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exc_builder_event.dart';
part 'exc_builder_state.dart';

class ExcBuilderBloc extends Bloc<ExcBuilderEvent, ExcBuilderState> {
  ExcBuilderBloc() : super(ExcBuilderInitial()) {
    on<ExcBuilderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
