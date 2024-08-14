part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLogoutRequested extends AuthEvent {}

final class _AuthUserChanged extends AuthEvent {
  final User user;
  const _AuthUserChanged(this.user);
}
