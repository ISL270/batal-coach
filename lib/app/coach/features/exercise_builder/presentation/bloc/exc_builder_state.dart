part of 'exc_builder_bloc.dart';

sealed class ExcBuilderState extends Equatable {
  const ExcBuilderState();
  
  @override
  List<Object> get props => [];
}

final class ExcBuilderInitial extends ExcBuilderState {}
