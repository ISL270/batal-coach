import 'package:btl/app/features/authentication/data/models/remote/user_info_rm.dart';
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
  @override
  UserInfoRM fromDomain(User user) => switch (user) {
        Coach() => const FireCoachInfo(),
        Trainee() => FireTraineeInfo(coachEmail: user.coachEmail),
      };
}

@JsonSerializable()
final class FireCoachInfo extends FireUserInfo {
  const FireCoachInfo();
  factory FireCoachInfo.fromJson(Map<String, dynamic> json) => _$FireCoachInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FireCoachInfoToJson(this);

  @override
  Coach toDomain({
    required String uid,
    required String email,
    String? phoneNumber,
    String? photo,
    String? name,
  }) =>
      Coach(
        id: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photo: photo,
      );
}

@JsonSerializable()
final class FireTraineeInfo extends FireUserInfo {
  final String coachEmail;

  const FireTraineeInfo({required this.coachEmail});

  factory FireTraineeInfo.fromJson(Map<String, dynamic> json) => _$FireTraineeInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FireTraineeInfoToJson(this);

  @override
  Trainee toDomain({
    required String uid,
    required String email,
    String? phoneNumber,
    String? photo,
    String? name,
  }) =>
      Trainee(
        id: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        photo: photo,
        coachEmail: coachEmail,
      );
}
