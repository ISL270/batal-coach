import 'dart:async';

import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/data/models/remote/auth_exceptions.dart';
import 'package:btl/app/features/authentication/domain/models/auth_state.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

/// Manages authentication-related operations and user state in the application.
///
/// This repository handles user authentication processes including:
/// - Sign up
/// - Sign in
/// - Sign out
/// - Google Sign In
/// - User state management
///
/// It uses Firebase Authentication and maintains a reactive stream of [AuthState]
/// to track the current authentication status.
@singleton
final class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final fire_auth.FirebaseAuth _fireAuth;
  final UserRepository _userRepository;

  AuthRepository(
    this._fireAuth,
    this._googleSignIn,
    this._userRepository,
  ) {
    _init();
  }

  final _subject = BehaviorSubject<AuthState>.seeded(const Unauthenticated());

  /// Provides a broadcast stream of authentication state changes
  ///
  /// Listeners can subscribe to this stream to react to authentication status updates
  ///
  /// Returns a [Stream] of [AuthState]
  Stream<AuthState> stream() => _subject.asBroadcastStream();

  /// Gets the current authentication state
  ///
  /// Returns the latest [AuthState] from the subject
  AuthState get authState => _subject.value;

  /// Gets the current user
  ///
  /// Returns the user associated with the current authentication state
  /// or `null` if the state is [Unauthenticated]
  User? get user => switch (authState) {
        Authenticated(user: final user) => user,
        Unauthenticated() => null,
      };

  /// Initializes the authentication repository
  ///
  /// Attempts to retrieve a local user and update the authentication state:
  /// - If a local user exists, sets state to [Authenticated]
  /// - If no local user is found, sets state to [Unauthenticated]
  ///
  /// This method is called automatically after construction
  void _init() {
    if (_userRepository.cachedUser != null) {
      _subject.add(Authenticated(_userRepository.cachedUser!, false));
    } else {
      _subject.add(const Unauthenticated());
    }
  }

  Future<void> signUp(
    UserType userType, {
    required String coachEmail,
    required String companyName,
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
    required CoachType coachType,
  }) async {
    try {
      final userCredential = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw SignUpWithEmailAndPasswordException.fromCode('user_not_found');
      }

      final res = await _userRepository.saveUserInfoRemote(
        uid: userCredential.user!.uid,
        userType: userType,
        coachEmail: coachEmail,
        email: email,
        name: name,
        companyName: companyName,
        phoneNumber: phoneNumber,
        coachType: coachType,
      );

      await res.fold(
        (e) => throw SignUpWithEmailAndPasswordException.fromCode(e.code),
        (user) async {
          _subject.add(Authenticated(user, true));
          await _userRepository.saveUserLocally(user);
        },
      );
    } catch (e) {
      throw switch (e) {
        (final fire_auth.FirebaseAuthException e) =>
          SignUpWithEmailAndPasswordException.fromCode(e.code),
        _ => const SignUpWithEmailAndPasswordException(),
      };
    }
  }

  Future<void> logInWithEmail(
    UserType userType, {
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw LogInWithEmailAndPasswordException.fromCode('user_not_found');
      }

      final res = await _userRepository.getUserRemote(uid: userCredential.user!.uid);

      await res.fold(
        (e) => throw LogInWithEmailAndPasswordException.fromCode(e.code),
        (user) async {
          _subject.add(Authenticated(user, true));
          await _userRepository.saveUserLocally(user);
        },
      );
    } catch (e) {
      throw switch (e) {
        (final fire_auth.FirebaseAuthException e) =>
          LogInWithEmailAndPasswordException.fromCode(e.code),
        _ => const LogInWithEmailAndPasswordException(),
      };
    }
  }

  Future<void> logInWithGoogle(UserType userType) async {
    try {
      late final fire_auth.AuthCredential credential;

      if (kIsWeb) {
        final googleProvider = fire_auth.GoogleAuthProvider();
        final userCredential = await _fireAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = fire_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      final userCredential = await _fireAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw LogInWithGoogleException.fromCode('user_not_found');
      }

      final res = await _userRepository.getUserRemote(
        uid: userCredential.user!.uid,
      );

      await res.fold(
        (e) => throw LogInWithGoogleException.fromCode(e.code),
        (user) async {
          _subject.add(Authenticated(user, true));
          await _userRepository.saveUserLocally(user);
        },
      );
    } catch (e) {
      throw switch (e) {
        (final fire_auth.FirebaseAuthException e) => LogInWithGoogleException.fromCode(e.code),
        _ => const LogInWithGoogleException(),
      };
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _fireAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      _subject.add(const Unauthenticated());
      await _userRepository.deleteLocalUser();
    } catch (_) {
      throw BusinessException.unkown();
    }
  }

  @disposeMethod
  void dispose() {
    _subject.close();
  }
}
