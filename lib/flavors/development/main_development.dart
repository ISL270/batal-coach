import 'package:btl/app.dart';
import 'package:btl/bootstrap.dart';
import 'package:btl/flavors/development/firebase_options_dev.dart';
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
