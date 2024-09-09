part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final Status status;

  const AuthState._({
    required this.user,
    required this.status,
  });

  const AuthState.initial()
      : status = const Initial(),
        user = null;

  @override
  List<Object?> get props => [
        user,
        status,
      ];
}

extension AuthStateX on AuthState {
  AuthState success(User? user) => AuthState._(
        user: user,
        status: const Success(),
      );

  AuthState failure(GenericException exception) => AuthState._(
        user: user,
        status: Failure(exception),
      );

  AuthState loading() => AuthState._(
        user: user,
        status: const Loading(),
      );

  bool get isAuthenticated => user != null;
}
