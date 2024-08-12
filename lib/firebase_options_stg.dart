// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_stg.dart';
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
    apiKey: 'AIzaSyB3Q-Ve4SP6P0kn5-ROp2YnnHTz4S5_osk',
    appId: '1:471671834406:web:73b95fa05fa73bb9ece3e7',
    messagingSenderId: '471671834406',
    projectId: 'btl-stg',
    authDomain: 'btl-stg.firebaseapp.com',
    storageBucket: 'btl-stg.appspot.com',
    measurementId: 'G-5SZX6LKM7P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcJtvuQ0AZyEV90VdrlZCCyfsZb75n5Q0',
    appId: '1:471671834406:android:d510743bae52e2a4ece3e7',
    messagingSenderId: '471671834406',
    projectId: 'btl-stg',
    authDomain: 'btl-stg.firebaseapp.com',
    storageBucket: 'btl-stg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwykXgECTC-TVKk0vXQ-UufwIcyJlsULc',
    appId: '1:471671834406:ios:9153fe9af0bfd1e8ece3e7',
    messagingSenderId: '471671834406',
    projectId: 'btl-stg',
    authDomain: 'btl-stg.firebaseapp.com',
    storageBucket: 'btl-stg.appspot.com',
    iosBundleId: 'com.example.verygoodcore.btl.stg',
  );
}
