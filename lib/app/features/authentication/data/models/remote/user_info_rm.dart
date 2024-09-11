import 'package:btl/app/features/authentication/domain/models/user.dart';

abstract interface class UserInfoRM {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;

  UserInfoRM({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
  });

  User toDomain();

  UserInfoRM fromDomain(User user);

  Map<String, dynamic> toJson();
}
