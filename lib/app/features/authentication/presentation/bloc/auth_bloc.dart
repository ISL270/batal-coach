// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:btl/app/features/authentication/domain/models/auth_state.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:btl/app/features/login/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

/// Manages authentication state and related operations in the application
///
/// This Bloc handles:
/// - Authentication state tracking
/// - User login subscription
/// - Logout process
/// - Routing based on user type
///
/// Key Responsibilities:
/// - Listens to authentication repository updates
/// - Manages authentication state transitions
/// - Provides user-specific routing logic
@singleton
class AuthBloc extends Bloc<AuthEvent, Status<AuthState>> {
  final AuthRepository _authRepo;

  AuthBloc(this._authRepo) : super(const Initial(Unauthenticated())) {
    on<_AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    add(_AuthSubscriptionRequested());
  }

  /// Handles authentication subscription requests
  ///
  /// Listens to authentication repository and emits state updates
  ///
  /// [event] The subscription request event
  /// [emit] State emitter for updating bloc state
  Future<void> _onSubscriptionRequested(
    _AuthSubscriptionRequested event,
    Emitter<Status<AuthState>> emit,
  ) async {
    await emit.forEach(
      _authRepo.stream(),
      onData: (authState) => state.toSuccess(authState),
    );
  }

  /// Handles user logout requests
  ///
  /// Manages logout process:
  /// - Sets loading state
  /// - Calls repository logout method
  /// - Handles potential errors
  ///
  /// [event] The logout request event
  /// [emit] State emitter for updating bloc state
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<Status<AuthState>> emit,
  ) async {
    emit(state.toLoading());
    try {
      await _authRepo.logOut();
    } catch (e) {
      emit(state.toFailure(e as GenericException));
    }
  }

  /// Determines the home route based on user type
  ///
  /// Returns:
  /// - Exercises screen route for coaches
  /// - Throws [UnimplementedError] for other user types
  String get homeNamedRoute {
    return switch (state.user) {
      null => LoginScreen.name,
      Coach() => ExercisesScreen.name,
      _ => throw UnimplementedError(),
    };
  }

  /// Closes the bloc and disposes of authentication resources
  @override
  Future<void> close() {
    _authRepo.dispose();
    return super.close();
  }
}

/// Checks if the user type has changed between two authentication states
///
/// Useful for detecting user type transitions during authentication
///
/// [previous] The previous authentication status
/// [current] The current authentication status
///
/// Returns `true` if user type changed, `false` otherwise
bool hasUserTypeChanged(Status<AuthState> previous, Status<AuthState> current) {
  if (previous.isSuccess && current.isSuccess) {
    if (previous.data!.isAuthenticated && current.data!.isAuthenticated) {
      if (previous.user.runtimeType != current.user.runtimeType) {
        return true;
      }
      return false;
    }
    return false;
  }
  return false;
}

/// Extension methods for [Status<AuthState>] to simplify user access
extension AuthStatusX on Status<AuthState> {
  /// Retrieves the current user from the authentication state
  ///
  /// Returns:
  /// - The authenticated user if present
  /// - `null` for unauthenticated states
  User? get user => switch (data) {
        Authenticated(user: final user) => user,
        _ => null,
      };
}
