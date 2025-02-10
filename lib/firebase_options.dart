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
    apiKey: 'AIzaSyAZ7ctfoVKsGoz2LUp_7sDfQRDrKPFVnhk',
    appId: '1:123871368920:web:135706b6e9913c7c81a9ad',
    messagingSenderId: '123871368920',
    projectId: 'todolist-4548f',
    authDomain: 'todolist-4548f.firebaseapp.com',
    storageBucket: 'todolist-4548f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDP24BfVrTK8I-L-8Xvyd32kuBBi_xVEOs',
    appId: '1:123871368920:android:a46f4f826b3ca3ad81a9ad',
    messagingSenderId: '123871368920',
    projectId: 'todolist-4548f',
    storageBucket: 'todolist-4548f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJCLYSPPGEGBzFmNWoRktjJkY2gL5Ns3U',
    appId: '1:123871368920:ios:2d842cf3598c645081a9ad',
    messagingSenderId: '123871368920',
    projectId: 'todolist-4548f',
    storageBucket: 'todolist-4548f.firebasestorage.app',
    iosBundleId: 'com.example.todolist',
  );
}
