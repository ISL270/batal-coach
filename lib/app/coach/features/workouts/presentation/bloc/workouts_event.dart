part of 'workouts_bloc.dart';

sealed class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object> get props => [];
}

final class _WorkoutsSubscriptionRequested extends WorkoutsEvent {}
