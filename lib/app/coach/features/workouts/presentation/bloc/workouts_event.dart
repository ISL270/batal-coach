part of 'workouts_bloc.dart';

sealed class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object> get props => [];
}

final class _WkSubscriptionRequested extends WorkoutsEvent {}

final class WkSearched extends WorkoutsEvent {
  final String searchTerm;
  const WkSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class WkNextPageFetched extends WorkoutsEvent {}
