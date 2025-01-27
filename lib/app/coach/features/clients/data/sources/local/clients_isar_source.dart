import 'package:btl/app/coach/features/clients/data/sources/local/client_isar.dart';
import 'package:btl/app/coach/features/clients/domain/client.dart';
import 'package:btl/app/core/isar/isar_source.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@singleton
final class ClientsIsarSource extends IsarSource<Client, ClientIsar> {
  ClientsIsarSource(super.isarService);

  @override
  ClientIsar fromDomain(Client dm) => ClientIsar.fromDomain(dm);

  Future<int> putClient(ClientIsar client) => isarService.put<ClientIsar>(client);

  Future<List<ClientIsar>> getAllClients() => isarService.getAll<ClientIsar>();

  Future<List<ClientIsar>> getClients(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final query = switch (searchTerm.isNotBlank) {
      true => isarService.instance.clientIsars.where().nameStartsWith(searchTerm),
      false => isarService.instance.clientIsars.where().anyName(),
    };
    return query.offset(page * pageSize).limit(pageSize).findAll();
  }
}
