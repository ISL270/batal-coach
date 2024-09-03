// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;
  AuthBloc(this._authRepo) : super(const AuthState.initial()) {
    on<_AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    add(_AuthSubscriptionRequested());
  }

  Future<void> _onSubscriptionRequested(
    _AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach(
      _authRepo.getUserUpdates(),
      onData: (user) => state.success(user),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.loading());
    try {
      await _authRepo.logOut();
    } catch (e) {
      emit(state.failure(e as GenericException));
    }
  }
}
