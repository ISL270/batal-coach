import 'package:btl/app/coach/features/clients/domain/client.dart';
import 'package:btl/app/core/firestore/remote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_inputs/form_inputs.dart';

final class ClientFM implements RemoteModel<Client> {
  @override
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime lastActiveAt;

  ClientFM({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.lastActiveAt,
  });

  factory ClientFM.fromJson(String docID, Map<String, dynamic> json) => ClientFM(
        id: docID,
        name: json['name'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        lastActiveAt: (json['lastActiveAt'] as Timestamp).toDate(),
      );

  @override
  Client toDomain() => Client(
        id: id,
        name: Name.fromString(name),
        email: email,
        phoneNumber: phoneNumber,
        lastActiveAt: lastActiveAt,
      );
}
