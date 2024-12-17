part of 'sign_up_cubit.dart';

final class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    this.userType = UserType.coach,
    this.coachType = CoachType.fitnessCoach,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.coachEmail = const Email.pure(),
    this.password = const Password.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = const Initial(),
  });

  final UserType userType;
  final CoachType coachType;
  final Name name;
  final Email email;
  final Email coachEmail;
  final Password password;
  final ConfirmPassword confirmPassword;
  final PhoneNumber phoneNumber;
  final VoidStatus status;

  @override
  List<Object?> get props => [
        userType,
        coachType,
        name,
        email,
        coachEmail,
        password,
        confirmPassword,
        phoneNumber,
        status,
      ];

  SignUpState copyWith({
    UserType? userType,
    CoachType? coachType,
    Name? name,
    Email? email,
    Email? coachEmail,
    Password? password,
    ConfirmPassword? confirmedPassword,
    PhoneNumber? phoneNumber,
    VoidStatus? status,
  }) {
    return SignUpState(
      userType: userType ?? this.userType,
      coachType: coachType ?? this.coachType,
      name: name ?? this.name,
      email: email ?? this.email,
      coachEmail: coachEmail ?? this.coachEmail,
      password: password ?? this.password,
      confirmPassword: confirmedPassword ?? confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        name,
        email,
        if (userType.isTrainee) coachEmail,
        password,
        confirmPassword,
        phoneNumber,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unkown error';
  }
}
