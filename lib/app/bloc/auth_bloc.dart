import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authRepo;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({required AuthenticationRepository authRepo})
      : _authRepo = authRepo,
        super(
          authRepo.currentUser.isNotEmpty
              ? AuthState.authenticated(authRepo.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<_AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepo.user.listen(
      (user) => add(_AuthUserChanged(user)),
    );
  }

  void _onUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authRepo.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
