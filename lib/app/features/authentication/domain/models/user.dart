import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.userType,
    this.name,
    this.photo,
    this.phoneNumber,
  });

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// The current user's email address.
  final String email;

  final String? phoneNumber;

  /// Url for the current user's photo.
  final String? photo;

  final UserType userType;

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
        phoneNumber,
        userType,
      ];

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, photo: $photo, userType: $userType)';
  }
}
