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
    apiKey: '',
    appId: '1:138269778259:web:4825ee186a4193bd85c1a6',
    messagingSenderId: '138269778259',
    projectId: 'certificatestudyaiffelcore12th',
    authDomain: 'certificatestudyaiffelcore12th.firebaseapp.com',
    storageBucket: 'certificatestudyaiffelcore12th.firebasestorage.app',
    measurementId: 'G-D1NZ0MCPSC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:138269778259:android:600c96b00125157c85c1a6',
    messagingSenderId: '138269778259',
    projectId: 'certificatestudyaiffelcore12th',
    storageBucket: 'certificatestudyaiffelcore12th.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:138269778259:ios:ba5dbeb283ba8d1285c1a6',
    messagingSenderId: '138269778259',
    projectId: 'certificatestudyaiffelcore12th',
    storageBucket: 'certificatestudyaiffelcore12th.firebasestorage.app',
    androidClientId: '138269778259-aj13c8mimc8jjrg6mmcgaodfgoojslv0.apps.googleusercontent.com',
    iosBundleId: 'com.example.certificatestudy2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '1:138269778259:ios:ba5dbeb283ba8d1285c1a6',
    messagingSenderId: '138269778259',
    projectId: 'certificatestudyaiffelcore12th',
    storageBucket: 'certificatestudyaiffelcore12th.firebasestorage.app',
    androidClientId: '138269778259-aj13c8mimc8jjrg6mmcgaodfgoojslv0.apps.googleusercontent.com',
    iosBundleId: 'com.example.certificatestudy2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '',
    appId: '1:138269778259:web:2c33830f8a5b997385c1a6',
    messagingSenderId: '138269778259',
    projectId: 'certificatestudyaiffelcore12th',
    authDomain: 'certificatestudyaiffelcore12th.firebaseapp.com',
    storageBucket: 'certificatestudyaiffelcore12th.firebasestorage.app',
    measurementId: 'G-SD9DT10Q32',
  );

}
