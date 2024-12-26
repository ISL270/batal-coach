import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/isar/cache_model.dart';
import 'package:isar/isar.dart';

part 'client_isar.g.dart';

@collection
final class ClientIsar extends CacheModel<Client> {
  @override
  String id;

  @Index(type: IndexType.value, caseSensitive: false)
  String name;

  String email;

  String phone;
  String lastActive;

  ClientIsar({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.lastActive,
  });

  factory ClientIsar.fromDomain(Client domain) => ClientIsar(
      id: domain.id,
      name: domain.name,
      email: domain.email,
      phone: domain.phoneNumber,
      lastActive: domain.lastActive);

  @override
  Client toDomain() {
    return Client(
      id: id,
      name: name,
      email: email,
      phoneNumber: phone,
      lastActive: lastActive,
    );
  }
}
