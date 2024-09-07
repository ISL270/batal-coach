import 'package:btl/app/features/authentication/data/models/local/user_cm.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
final class UserIsar implements UserCM {
  @override
  Id cacheID = Isar.autoIncrement;

  @override
  String? coachEmail;

  @override
  String email;

  @override
  String uid;

  @override
  String name;

  @override
  String? phoneNumber;

  @override
  String? photo;

  @override
  @enumerated
  UserType userType;

  UserIsar({
    required this.uid,
    required this.email,
    required this.name,
    required this.userType,
    required this.photo,
    required this.phoneNumber,
    this.coachEmail,
  });

  @override
  User toDomain() => switch (userType) {
        UserType.coach => Coach(
            id: uid,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
            photo: photo,
          ),
        UserType.trainee => Trainee(
            id: uid,
            email: email,
            coachEmail: coachEmail!,
            name: name,
            phoneNumber: phoneNumber,
            photo: photo,
          ),
      };

  factory UserIsar.fromDomain(User user) => switch (user) {
        Coach() => UserIsar(
            uid: user.id,
            //TODO: make name required.
            name: user.name ?? '',
            email: user.email,
            photo: user.photo,
            phoneNumber: user.phoneNumber,
            userType: UserType.coach,
          ),
        Trainee() => UserIsar(
            uid: user.id,
            //TODO: make name required.
            name: user.name ?? '',
            email: user.email,
            photo: user.photo,
            phoneNumber: user.phoneNumber,
            coachEmail: user.coachEmail,
            userType: UserType.trainee,
          ),
      };
}
