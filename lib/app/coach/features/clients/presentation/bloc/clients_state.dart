part of 'clients_bloc.dart';

final class ClientsState extends Equatable {
  final VoidStatus status;
  final String searchTerm;
  final PaginatedResult<Client> client;

  const ClientsState({
    this.searchTerm = '',
    this.status = const Initial(),
    this.client = const PaginatedResult(),
  });

  ClientsState copyWith({
    VoidStatus? status,
    String? searchTerm,
    PaginatedResult<Client>? client,
  }) {
    return ClientsState(
      status: status ?? this.status,
      client: client ?? this.client,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object> get props => [status, searchTerm, client];
}
