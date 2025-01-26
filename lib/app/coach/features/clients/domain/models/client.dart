import 'package:form_inputs/form_inputs.dart';

final class Client {
  final String id;

  final Name name;

  final String email;

  final String phoneNumber;

  final DateTime lastActiveAt;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.lastActiveAt,
  });
}
