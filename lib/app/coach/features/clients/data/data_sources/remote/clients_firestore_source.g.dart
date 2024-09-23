// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_firestore_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FireClient _$FireClientFromJson(Map<String, dynamic> json) => _FireClient(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$FireClientToJson(_FireClient instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
