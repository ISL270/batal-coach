import 'package:btl/app.dart';
import 'package:btl/bootstrap.dart';
import 'package:btl/flavors/staging/firebase_options_stg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'btl-stg',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(App.new);
}
