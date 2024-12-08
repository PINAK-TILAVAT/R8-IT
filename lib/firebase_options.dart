// File generated by FlutterFire CLI.
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
    apiKey: 'AIzaSyDMkR0qcx9akFhw6y81VZGY1hE1sePrYVQ',
    appId: '1:222675142277:web:a5b078e91bf9478c73cbec',
    messagingSenderId: '222675142277',
    projectId: 'r8-it-de492',
    authDomain: 'r8-it-de492.firebaseapp.com',
    storageBucket: 'r8-it-de492.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8CG-dd8wITbo977az8oBlxIVOJzeoWHQ',
    appId: '1:222675142277:android:d1fc8bc1d281dbf773cbec',
    messagingSenderId: '222675142277',
    projectId: 'r8-it-de492',
    storageBucket: 'r8-it-de492.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN6orLmIG90OuK4L7cMV8EAglRQOEuAOw',
    appId: '1:222675142277:ios:559b54683b3413e973cbec',
    messagingSenderId: '222675142277',
    projectId: 'r8-it-de492',
    storageBucket: 'r8-it-de492.firebasestorage.app',
    iosBundleId: 'com.example.r8It',
  );
}