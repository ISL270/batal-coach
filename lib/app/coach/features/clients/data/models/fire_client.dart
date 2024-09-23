part of '../data_sources/remote/clients_firestore_source.dart';

@JsonSerializable()
final class _FireClient implements ClientRM {
  @override
  @JsonKey(name: 'uid')
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String phoneNumber;

  _FireClient({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory _FireClient.fromJson(Map<String, dynamic> json) => _$FireClientFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FireClientToJson(this);

  @override
  Client toDomain() => Client(
        id: id,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );
}
