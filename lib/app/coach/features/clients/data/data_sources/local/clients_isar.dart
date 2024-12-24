import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/isar/cache_model.dart';
import 'package:isar/isar.dart';

part 'clients_isar.g.dart';

@collection
final class ClientsIsar extends CacheModel<Client> {
  @override
  String id;

  @Index(type: IndexType.value, caseSensitive: false)
  String name;

  String email;

  String phone;

  ClientsIsar({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory ClientsIsar.fromDomain(Client domain) => ClientsIsar(
        id: domain.id,
        name: domain.name,
        email: domain.email,
        phone: domain.phoneNumber,
      );

  @override
  Client toDomain() {
    return Client(
      id: id,
      name: name,
      email: email,
      phoneNumber: phone,
    );
  }
}
