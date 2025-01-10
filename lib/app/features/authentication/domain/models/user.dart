import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:equatable/equatable.dart';

sealed class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    // this.photo,
  });

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// The current user's email address.
  final String email;

  final String phoneNumber;

  /// Url for the current user's photo.
  // final String? photo;

  // Getters
  bool get isCoach => runtimeType == Coach;
  bool get isTrainee => runtimeType == Trainee;

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        // photo,
        phoneNumber,
      ];
}

final class Coach extends User {
  final CoachType coachType;
  final String? companyName;

  const Coach({
    required super.id,
    required super.email,
    required super.name,
    required super.phoneNumber,
    required this.coachType,
    this.companyName,
    // super.photo,
  });

  @override
  List<Object?> get props => [
        super.props,
        coachType,
        companyName,
      ];
}

final class Trainee extends User {
  final String coachEmail;

  const Trainee({
    required super.id,
    required super.email,
    required this.coachEmail,
    required super.name,
    required super.phoneNumber,
    // super.photo,
  });

  @override
  List<Object?> get props => [
        super.props,
        coachEmail,
      ];
}
