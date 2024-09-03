part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final Status status;
  final GenericException? exception;

  const AuthState._({
    required this.user,
    required this.status,
    required this.exception,
  });

  const AuthState.initial()
      : status = Status.initial,
        user = null,
        exception = null;

  @override
  List<Object?> get props => [
        user,
        status,
        exception,
      ];
}

extension AuthStateX on AuthState {
  AuthState success(User? user) => AuthState._(
        user: user,
        exception: null,
        status: Status.success,
      );

  AuthState failure(GenericException? exception) => AuthState._(
        user: user,
        exception: exception,
        status: Status.failure,
      );

  AuthState loading() => AuthState._(
        user: user,
        exception: exception,
        status: Status.loading,
      );

  bool get isAuthenticated => user != null;
}
