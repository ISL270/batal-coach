import 'package:btl/app/core/isar/cache_model.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
final class UserIsar extends CacheModel<User> {
  String? coachEmail;
  String? companyName;

  String email;

  @override
  String id;

  String name;

  String phoneNumber;

  @enumerated
  UserType userType;
  @enumerated
  CoachType coachType;

  UserIsar({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    required this.phoneNumber,
    this.coachType = CoachType.fitnessCoach,
    this.coachEmail,
    this.companyName,
  });

  @override
  User toDomain() => switch (userType) {
        UserType.coach => Coach(
            id: id,
            email: email,
            coachType: coachType,
            name: name,
            phoneNumber: phoneNumber,
          ),
        UserType.trainee => Trainee(
            id: id,
            email: email,
            coachEmail: coachEmail ?? '',
            name: name,
            phoneNumber: phoneNumber,
          ),
      };

  factory UserIsar.fromDomain(User user) => switch (user) {
        Coach() => UserIsar(
            id: user.id,
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            userType: UserType.coach,
            coachType: user.coachType),
        Trainee() => UserIsar(
            id: user.id,
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            coachEmail: user.coachEmail,
            userType: UserType.trainee,
          ),
      };
}
