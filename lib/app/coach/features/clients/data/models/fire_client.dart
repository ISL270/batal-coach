import 'package:btl/app/coach/features/clients/data/models/client_rm.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fire_client.g.dart';

@JsonSerializable()
final class FireClient implements ClientRM {
  @override
  @JsonKey(name: 'uid')
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String phoneNumber;

  FireClient({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory FireClient.fromJson(Map<String, dynamic> json) => _$FireClientFromJson(json);

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
