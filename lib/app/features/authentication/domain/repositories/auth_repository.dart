import 'dart:async';

import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/features/authentication/data/models/remote/auth_exceptions.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final fire_auth.FirebaseAuth _fireAuth;
  final UserRepository _userRepository;

  AuthRepository(
    this._fireAuth,
    this._googleSignIn,
    this._userRepository,
  );

  // Using BehaviorSubject, any new listeners when begin listening to the stream,
  // they immediately get the lastly emitted Stream of data.
  final _userStream = BehaviorSubject<User?>.seeded(null);

  Stream<User?> getUserUpdates() => _userStream.asBroadcastStream();

  User? get user => _userStream.value;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final fireUser = _fireAuth.currentUser;
    if (fireUser == null) return;
    try {
      final user = await _userRepository.getLocalUser();
      _userStream.add(user);
    } catch (_) {}
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordException] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String coachEmail,
    required String password,
    required UserType userType,
  }) async {
    try {
      final userCredential = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) return;

      final user = await _userRepository.saveUserInfoRemote(
        userType: userType,
        coachEmail: coachEmail,
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        photo: userCredential.user!.photoURL,
        name: userCredential.user!.displayName,
        phoneNumber: userCredential.user!.phoneNumber,
      );

      _userStream.add(user);
      await _userRepository.saveUserLocally(user);
    } catch (e) {
      throw switch (e) {
        (final fire_auth.FirebaseAuthException e) =>
          SignUpWithEmailAndPasswordException.fromCode(e.code),
        _ => const SignUpWithEmailAndPasswordException(),
      };
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordException] if an exception occurs.
  Future<void> logInWithEmail({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      final userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) return;

      final user = await _userRepository.getFullUserRemote(
        userType: userType,
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        photo: userCredential.user!.photoURL,
        name: userCredential.user!.displayName,
        phoneNumber: userCredential.user!.phoneNumber,
      );

      _userStream.add(user);
      await _userRepository.saveUserLocally(user!);
    } catch (e) {
      throw switch (e) {
        (final fire_auth.FirebaseAuthException e) =>
          LogInWithEmailAndPasswordException.fromCode(e.code),
        _ => const LogInWithEmailAndPasswordException(),
      };
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleException] if an exception occurs.
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
      if (userCredential.user == null) return;

      final user = await _userRepository.getFullUserRemote(
        userType: userType,
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.displayName,
        photo: userCredential.user!.photoURL,
        phoneNumber: userCredential.user!.phoneNumber,
      );
      _userStream.add(user);
      await _userRepository.saveUserLocally(user!);
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
      _userStream.add(null);
      await _userRepository.deleteLocallySavedUser();
    } catch (_) {
      throw const BusinessException(
        code: '',
        message: 'An unknown exception occurred.',
      );
    }
  }

  @disposeMethod
  void dispose() {
    _userStream.close();
  }
}
