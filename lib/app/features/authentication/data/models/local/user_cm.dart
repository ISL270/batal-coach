import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';

abstract interface class UserCM extends CacheModel {
  final String uid;
  final String email;
  final String name;
  final UserType userType;
  final String phoneNumber;
  final String? coachEmail;

  UserCM({
    required super.cacheID,
    required this.uid,
    required this.email,
    required this.name,
    required this.userType,
    required this.phoneNumber,
    required this.coachEmail,
  });

  User toDomain();
}
