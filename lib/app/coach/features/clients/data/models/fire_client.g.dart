// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireClient _$FireClientFromJson(Map<String, dynamic> json) => FireClient(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$FireClientToJson(FireClient instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
