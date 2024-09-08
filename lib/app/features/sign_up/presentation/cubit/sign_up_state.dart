part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    this.email = const Email.pure(),
    this.coachEmail = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.userType = UserType.coach,
    this.errorMessage,
  });

  final Email email;
  final Email coachEmail;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus status;
  final UserType userType;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        coachEmail,
        password,
        confirmedPassword,
        status,
        userType,
        errorMessage,
      ];

  SignUpState copyWith({
    Email? email,
    Email? coachEmail,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzSubmissionStatus? status,
    String? errorMessage,
    UserType? userType,
  }) {
    return SignUpState(
      email: email ?? this.email,
      coachEmail: coachEmail ?? this.coachEmail,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      userType: userType ?? this.userType,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        email,
        if (userType.isTrainee) coachEmail,
        password,
        confirmedPassword,
      ];
}
