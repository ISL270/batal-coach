import 'package:btl/app/view/app.dart';
import 'package:btl/bootstrap.dart';
import 'package:btl/firebase_options/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'btl-dev',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(App.new);
}
