import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/app.dart';
import 'package:btl/bootstrap.dart';
import 'package:btl/firebase_options/firebase_options_prod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'btl-prod',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  await bootstrap(() => App(authRepo: authenticationRepository));
}
