import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;

extension UserX on User {
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? photo,
    UserType? userType,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
      userType: userType ?? this.userType,
    );
  }

  /// Maps a [fireAuth.User] into a [User].
  User fromFireUser(fireAuth.User user, UserType userType) {
    return User(
      id: user.uid,
      email: user.email!,
      name: user.displayName,
      photo: user.photoURL,
      phoneNumber: user.phoneNumber,
      userType: userType,
    );
  }
}
