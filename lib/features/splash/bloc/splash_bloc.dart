import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<_SplashInitiated>(_onInitiated);
    add(_SplashInitiated());
  }

  Future<void> _onInitiated(SplashEvent event, Emitter<SplashState> emit) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    emit(SplashSuccess());
  }
}
