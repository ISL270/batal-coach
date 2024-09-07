import 'package:btl/app/features/authentication/domain/models/user.dart';

abstract interface class UserInfoRM {
  UserInfoRM();

  User toDomain({
    required String uid,
    required String email,
    required String? phoneNumber,
    required String? photo,
    required String? name,
  });

  UserInfoRM fromDomain(User user);

  Map<String, dynamic> toJson();
}
