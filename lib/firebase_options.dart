// File generated (and re-generated) by the FlutterFire CLI, not by hand.
//
// This checked-in copy is a PLACEHOLDER — the values below are not real
// credentials and will not connect to any Firebase project. Before running
// the app, replace this entire file by running, from the project root:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// That command creates (or reuses) a Firebase project, registers the
// Android/iOS/web apps, downloads the platform config files
// (google-services.json / GoogleService-Info.plist) into the right
// directories, and overwrites this file with the real API keys and app IDs
// for your project. See https://firebase.google.com/docs/flutter/setup for
// the full walkthrough.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    appId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    messagingSenderId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    projectId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    authDomain: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    storageBucket: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    appId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    messagingSenderId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    projectId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    storageBucket: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    appId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    messagingSenderId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    projectId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    storageBucket: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    iosBundleId: 'com.dicoding.ditonton',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    appId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    messagingSenderId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    projectId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    storageBucket: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    iosBundleId: 'com.dicoding.ditonton',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    appId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    messagingSenderId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    projectId: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
    storageBucket: 'REPLACE_WITH_flutterfire_configure_OUTPUT',
  );
}
