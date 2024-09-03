import 'dart:async';

import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/features/authentication/data/models/auth_exceptions.dart';
import 'package:btl/app/features/authentication/data/models/fire_user_x.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final fire_auth.FirebaseAuth _fireAuth;

  AuthRepository(
    this._firestore,
    this._fireAuth,
    this._googleSignIn,
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
      final userInfo = await _firestore.collection('users').doc(fireUser.uid).get();
      final userType = userInfo.data()!['userType'] as String;
      final user = fireUser.toBTLuser(UserType.fromJson(userType));
      _userStream.add(user);
    } catch (_) {}
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordException] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      final userCredential = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'userType': userType.toJson()});

      final user = userCredential.user!.toBTLuser(userType);
      _userStream.add(user);
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
  }) async {
    try {
      final userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userInfo = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      final userType = userInfo.data()!['userType'] as String;
      final user = userCredential.user!.toBTLuser(UserType.fromJson(userType));
      _userStream.add(user);
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
  Future<void> logInWithGoogle() async {
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
      final userInfo = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      final userType = userInfo.data()!['userType'] as String;
      final user = userCredential.user!.toBTLuser(UserType.fromJson(userType));
      _userStream.add(user);
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
    } catch (_) {
      throw const BusinessException(
        code: '',
        message: 'An unknown exception occurred.',
      );
    }
  }

  void dispose() {
    _userStream.close();
  }
}
