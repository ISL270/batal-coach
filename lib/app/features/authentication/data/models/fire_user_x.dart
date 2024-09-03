import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

extension FireUserX on fire_auth.User {
  /// Maps a [fire_auth.User] into a [User].
  User toBTLuser(UserType userType) {
    return User(
      id: uid,
      email: email!,
      name: displayName,
      photo: photoURL,
      phoneNumber: phoneNumber,
      userType: userType,
    );
  }
}
