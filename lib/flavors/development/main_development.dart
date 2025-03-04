import 'package:btl/app/app.dart';
import 'package:btl/bootstrap.dart';
import 'package:btl/flavors/development/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  await Firebase.initializeApp(
    name: 'btl-dev',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(App.new);
}
