import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/firestore/remote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_fm.g.dart';

@JsonSerializable()
final class ClientFM implements RemoteModel<Client> {
  @JsonKey(name: 'uid')
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime lastActive;

  ClientFM({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.lastActive,
  });

  factory ClientFM.fromJson(String docID, Map<String, dynamic> json) =>
      ClientFM(
        id: docID,
        name: json['name'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        lastActive: (json['lastActive'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => _$ClientFMToJson(this);

  @override
  Client toDomain() => Client(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        lastActive: lastActive,
      );
}
