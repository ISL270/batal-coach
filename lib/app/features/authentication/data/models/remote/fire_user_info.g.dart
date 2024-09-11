// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FireCoachInfo _$FireCoachInfoFromJson(Map<String, dynamic> json) =>
    FireCoachInfo(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$FireCoachInfoToJson(FireCoachInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
    };

FireTraineeInfo _$FireTraineeInfoFromJson(Map<String, dynamic> json) =>
    FireTraineeInfo(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      coachEmail: json['coachEmail'] as String,
    );

Map<String, dynamic> _$FireTraineeInfoToJson(FireTraineeInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'coachEmail': instance.coachEmail,
    };
