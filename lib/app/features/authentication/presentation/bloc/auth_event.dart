part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class _AuthSubscriptionRequested extends AuthEvent {}

final class AuthLogoutRequested extends AuthEvent {}
