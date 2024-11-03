import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/models/remote_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_fm.g.dart';

@JsonSerializable()
final class ClientFM implements RemoteModel<Client> {
  @JsonKey(name: 'uid')
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  ClientFM({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory ClientFM.fromJson(Map<String, dynamic> json) => _$ClientFMFromJson(json);

  Map<String, dynamic> toJson() => _$ClientFMToJson(this);

  @override
  Client toDomain() => Client(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );
}
