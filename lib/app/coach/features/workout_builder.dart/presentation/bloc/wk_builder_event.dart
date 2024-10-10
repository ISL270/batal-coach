part of 'wk_builder_bloc.dart';

sealed class WkBuilderEvent extends Equatable {
  const WkBuilderEvent();

  @override
  List<Object> get props => [];
}

final class WkBuilderInitial extends WkBuilderEvent {
  const WkBuilderInitial();

  @override
  List<Object> get props => [];
}
