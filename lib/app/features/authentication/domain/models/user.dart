import 'package:btl/app/core/models/domain_model.dart';
import 'package:equatable/equatable.dart';

sealed class User extends Equatable implements DomainModel {
  const User({
    required this.id,
    required this.email,
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

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
        phoneNumber,
      ];
}

final class Coach extends User {
  const Coach({
    required super.id,
    required super.email,
    super.name,
    super.phoneNumber,
    super.photo,
  });
  @override
  List<Object?> get props => [super.props];
}

final class Trainee extends User {
  final String coachEmail;

  const Trainee({
    required super.id,
    required super.email,
    required this.coachEmail,
    super.name,
    super.phoneNumber,
    super.photo,
  });
  @override
  List<Object?> get props => [
        super.props,
        coachEmail,
      ];
}
