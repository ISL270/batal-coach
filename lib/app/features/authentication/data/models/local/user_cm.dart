import 'package:btl/app/core/models/cache_model.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';

abstract interface class UserCM extends CacheModel<User> {
  String uid;
  String email;
  String name;
  UserType userType;
  String phoneNumber;
  String? coachEmail;

  UserCM({
    required this.uid,
    required this.email,
    required this.name,
    required this.userType,
    required this.phoneNumber,
    required this.coachEmail,
  });
}
