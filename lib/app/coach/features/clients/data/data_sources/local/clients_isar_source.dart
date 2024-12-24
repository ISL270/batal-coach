import 'package:btl/app/coach/features/clients/data/data_sources/local/clients_isar.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/isar/isar_source.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@singleton
final class ClientsIsarSource extends IsarSource<Client, ClientsIsar> {
  ClientsIsarSource(super.isarService);

  @override
  ClientsIsar fromDomain(Client dm) => ClientsIsar.fromDomain(dm);

  Future<int> putClient(ClientsIsar client) =>
      isarService.put<ClientsIsar>(client);

  Future<List<ClientsIsar>> getAllClients() =>
      isarService.getAll<ClientsIsar>();

  Future<List<ClientsIsar>> getClients(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final query = switch (searchTerm.isNotBlank) {
      true =>
        isarService.instance.clientsIsar.where().nameStartsWith(searchTerm),
      false => isarService.instance.clientsIsar.where().anyName(),
    };
    return query.offset(page * pageSize).limit(pageSize).findAll();
  }
}
