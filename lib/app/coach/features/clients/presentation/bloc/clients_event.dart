part of 'clients_bloc.dart';

sealed class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

final class _ClientsSubscriptionRequested extends ClientsEvent {}
