import 'package:btl/app/core/isar/cache_model.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:isar/isar.dart';

part 'user_isar.g.dart';

@collection
final class UserIsar extends CacheModel<User> {
  @override
  final String id;

  final String email;
  // Trainee related
  final String? coachEmail;

  final String name;

  final String phoneNumber;

  @Enumerated(EnumType.name)
  final UserType userType;

  // Coach related
  @Enumerated(EnumType.name)
  final CoachType? coachType;
  // Coach related
  final String? companyName;

  const UserIsar({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    required this.phoneNumber,
    this.coachType,
    this.coachEmail,
    this.companyName,
  });

  factory UserIsar.fromDomain(User user) => switch (user) {
        Coach() => UserIsar(
            id: user.id,
            name: user.name,
            email: user.email,
            userType: UserType.coach,
            coachType: user.coachType,
            companyName: user.companyName,
            phoneNumber: user.phoneNumber,
          ),
        Trainee() => UserIsar(
            id: user.id,
            name: user.name,
            email: user.email,
            userType: UserType.trainee,
            coachEmail: user.coachEmail,
            phoneNumber: user.phoneNumber,
          ),
      };

  @override
  User toDomain() => switch (userType) {
        UserType.coach => Coach(
            id: id,
            name: name,
            email: email,
            coachType: coachType!,
            companyName: companyName,
            phoneNumber: phoneNumber,
          ),
        UserType.trainee => Trainee(
            id: id,
            email: email,
            coachEmail: coachEmail!,
            name: name,
            phoneNumber: phoneNumber,
          ),
      };
}
