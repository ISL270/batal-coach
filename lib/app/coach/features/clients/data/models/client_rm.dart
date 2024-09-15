import 'package:btl/app/coach/features/clients/domain/models/client.dart';

abstract interface class ClientRM {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  ClientRM({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  Client toDomain();

  Map<String, dynamic> toJson();
}
