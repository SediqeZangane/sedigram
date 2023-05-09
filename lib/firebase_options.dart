// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
// ignore: combinators_ordering
    show
        defaultTargetPlatform,
        kIsWeb,
        TargetPlatform;

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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAEElCPUFEzCpJMKLaqkQLUpHL_rSUSl_E',
    appId: '1:627711550873:web:41d85d01d8aae859cc1f08',
    messagingSenderId: '627711550873',
    projectId: 'sedigramproject',
    authDomain: 'sedigramproject.firebaseapp.com',
    storageBucket: 'sedigramproject.appspot.com',
    measurementId: 'G-Q8HMEVEHM2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6yQcrGj7PDsmenaUUiUooyARTuSqHYyA',
    appId: '1:627711550873:android:984f140ff6b92e1bcc1f08',
    messagingSenderId: '627711550873',
    projectId: 'sedigramproject',
    storageBucket: 'sedigramproject.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkgc3yMVmnuPvyFvc45XWwAAUF7udRZf0',
    appId: '1:627711550873:ios:851c221400b5db96cc1f08',
    messagingSenderId: '627711550873',
    projectId: 'sedigramproject',
    storageBucket: 'sedigramproject.appspot.com',
    iosClientId:
        '627711550873-t06ettv4hc1hl5l9io0vo36ttovjjgtt.apps.googleusercontent.com',
    iosBundleId: 'com.example.sedigram',
  );
}
