import 'package:btl/app/features/authentication/data/models/remote/user_info_rm.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fire_user_info.g.dart';

sealed class FireUserInfo implements UserInfoRM {
  const FireUserInfo();

  factory FireUserInfo.fromJson(UserType userType, Map<String, dynamic> json) => switch (userType) {
        UserType.coach => FireCoachInfo.fromJson(json),
        UserType.trainee => FireTraineeInfo.fromJson(json),
      };

  factory FireUserInfo.fromUserType(
    UserType userType, {
    required String uid,
    required String coachEmail,
    required String email,
    required String name,
    required String companyName,
    required String phoneNumber,
    required CoachType coachType,
  }) =>
      switch (userType) {
        UserType.coach => FireCoachInfo(
            userType: userType,
            uid: uid,
            email: email,
            name: name,
            companyName: companyName,
            phoneNumber: phoneNumber,
            coachType: coachType,
          ),
        UserType.trainee => FireTraineeInfo(
            userType: userType,
            uid: uid,
            coachEmail: coachEmail,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
          ),
      };

  @override
  UserInfoRM fromDomain(User user) => switch (user) {
        Coach() => FireCoachInfo(
            userType: userType,
            uid: user.id,
            email: user.email,
            name: user.name,
            companyName: user.companyName,
            phoneNumber: user.phoneNumber,
            coachType: user.coachType,
          ),
        Trainee() => FireTraineeInfo(
            userType: userType,
            uid: user.id,
            email: user.email,
            name: user.name,
            phoneNumber: user.phoneNumber,
            coachEmail: user.coachEmail,
          ),
      };
}

@JsonSerializable(explicitToJson: true)
final class FireCoachInfo extends FireUserInfo {
  final CoachType coachType;
  String? companyName;
  @override
  final UserType userType;
  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String phoneNumber;

  FireCoachInfo({
    required this.userType,
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.coachType,
    this.companyName,
  });

  factory FireCoachInfo.fromJson(Map<String, dynamic> json) => _$FireCoachInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FireCoachInfoToJson(this);

  @override
  Coach toDomain() => Coach(
        id: uid,
        name: name,
        companyName: companyName,
        email: email,
        phoneNumber: phoneNumber,
        coachType: coachType,
      );
}

@JsonSerializable(explicitToJson: true)
final class FireTraineeInfo extends FireUserInfo {
  @override
  final UserType userType;
  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String phoneNumber;

  final String coachEmail;

  const FireTraineeInfo({
    required this.userType,
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.coachEmail,
  });

  factory FireTraineeInfo.fromJson(Map<String, dynamic> json) => _$FireTraineeInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FireTraineeInfoToJson(this);

  @override
  Trainee toDomain() => Trainee(
        id: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        coachEmail: coachEmail,
      );
}
