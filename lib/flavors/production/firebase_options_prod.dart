// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_prod.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUJKB_VdkoE6yC-179e1U_WF14EwUsbEY',
    appId: '1:474399213072:web:e4e340a1820f3f018cec95',
    messagingSenderId: '474399213072',
    projectId: 'btl-prod',
    authDomain: 'btl-prod.firebaseapp.com',
    storageBucket: 'btl-prod.appspot.com',
    measurementId: 'G-YE003JVRC3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeWOHtE3fDeaGhtxjrFLOI843T7izG8NQ',
    appId: '1:474399213072:android:ad811add16938f238cec95',
    messagingSenderId: '474399213072',
    projectId: 'btl-prod',
    authDomain: 'btl-prod.firebaseapp.com',
    storageBucket: 'btl-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDs_vhyHrFNry9cJUYcOhbpK4JWYviCboo',
    appId: '1:474399213072:ios:01235f9fc7beef388cec95',
    messagingSenderId: '474399213072',
    projectId: 'btl-prod',
    authDomain: 'btl-prod.firebaseapp.com',
    storageBucket: 'btl-prod.appspot.com',
    iosBundleId: 'com.example.verygoodcore.btl',
  );
}
