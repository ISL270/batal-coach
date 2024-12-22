part of 'clients_bloc.dart';

final class ClientsState extends Equatable {
  final List<Client> clients;
  final GenericException? exception;

  const ClientsState._({required this.clients, required this.exception});

  factory ClientsState.initial() =>
      const ClientsState._(clients: [], exception: null);

  ClientsState success(List<Client> clients) =>
      ClientsState._(clients: clients, exception: null);

  ClientsState failure(GenericException exception) =>
      ClientsState._(clients: clients, exception: exception);

  @override
  List<Object?> get props => [clients, exception];
}
