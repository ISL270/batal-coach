part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

final class ClientsSearched extends ClientsEvent {
  final String searchTerm;

  const ClientsSearched(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

final class _ClientsSubscriptionRequested extends ClientsEvent {}

final class ClientsNextPageFetched extends ClientsEvent {}
