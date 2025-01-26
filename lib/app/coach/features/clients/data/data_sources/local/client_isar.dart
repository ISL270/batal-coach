import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/isar/cache_model.dart';
import 'package:form_inputs/form_inputs.dart' as formz;
import 'package:isar/isar.dart';

part 'client_isar.g.dart';

@collection
final class ClientIsar extends CacheModel<Client> {
  @override
  final String id;

  @Index(type: IndexType.value, caseSensitive: false)
  final String name;

  final String email;

  final String phone;
  final DateTime lastActiveDate;

  const ClientIsar({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.lastActiveDate,
  });

  factory ClientIsar.fromDomain(Client domain) => ClientIsar(
        id: domain.id,
        name: domain.name.value,
        email: domain.email,
        phone: domain.phoneNumber,
        lastActiveDate: domain.lastActiveDate,
      );

  @override
  Client toDomain() {
    return Client(
      id: id,
      name: formz.Name.fromString(name),
      email: email,
      phoneNumber: phone,
      lastActiveDate: lastActiveDate,
    );
  }
}
