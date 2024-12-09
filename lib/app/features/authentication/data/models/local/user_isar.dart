import 'package:btl/app/core/extension_types/string_id.dart';
import 'package:btl/app/features/authentication/data/models/local/user_cm.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
final class UserIsar implements UserCM {
  @override
  Id get cacheID => uid.fastHash;

  @override
  String? coachEmail;

  @override
  String email;

  @override
  StringID uid;

  @override
  String name;

  @override
  String phoneNumber;

  @override
  @enumerated
  UserType userType;

  UserIsar({
    required this.uid,
    required this.email,
    required this.name,
    required this.userType,
    required this.phoneNumber,
    this.coachEmail,
  });

  @override
  User toDomain() => switch (userType) {
        UserType.coach => Coach(
            id: uid.value,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
          ),
        UserType.trainee => Trainee(
            id: uid.value,
            email: email,
            coachEmail: coachEmail!,
            name: name,
            phoneNumber: phoneNumber,
          ),
      };

  factory UserIsar.fromDomain(User user) => switch (user) {
        Coach() => UserIsar(
            uid: StringID(user.id),
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            userType: UserType.coach,
          ),
        Trainee() => UserIsar(
            uid: StringID(user.id),
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            coachEmail: user.coachEmail,
            userType: UserType.trainee,
          ),
      };
}
