// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_fm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientFM _$ClientFMFromJson(Map<String, dynamic> json) => ClientFM(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      lastActiveAt: DateTime.parse(json['lastActiveAt'] as String),
    );

Map<String, dynamic> _$ClientFMToJson(ClientFM instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'lastActiveAt': instance.lastActiveAt.toIso8601String(),
    };
