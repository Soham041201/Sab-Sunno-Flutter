// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:

/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );

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
    apiKey: 'AIzaSyBkGyUb05NfIPTotfcUZYnc-gIegzSS7Vc',
    appId: '1:706134238441:web:6f2ff8f55f74919c78fc78',
    messagingSenderId: '706134238441',
    projectId: 'sab-sunno',
    authDomain: 'sab-sunno.firebaseapp.com',
    storageBucket: 'sab-sunno.appspot.com',
    measurementId: 'G-9FEKLSFPVV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAV19ZkosdtH1labYUHJ8aCSDaNdG9IgWc',
    appId: '1:706134238441:android:c06333f9daa7573e78fc78',
    messagingSenderId: '706134238441',
    projectId: 'sab-sunno',
    storageBucket: 'sab-sunno.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiV-fVMbUtleGqsqFpPbbC42MH13UOInk',
    appId: '1:706134238441:ios:550d588f473ccbac78fc78',
    messagingSenderId: '706134238441',
    projectId: 'sab-sunno',
    storageBucket: 'sab-sunno.appspot.com',
    iosClientId: '706134238441-8chje5hlmdmr2j3661j46bcf7mkpebhj.apps.googleusercontent.com',
    iosBundleId: 'com.example.sabSunno',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiV-fVMbUtleGqsqFpPbbC42MH13UOInk',
    appId: '1:706134238441:ios:550d588f473ccbac78fc78',
    messagingSenderId: '706134238441',
    projectId: 'sab-sunno',
    storageBucket: 'sab-sunno.appspot.com',
    iosClientId: '706134238441-8chje5hlmdmr2j3661j46bcf7mkpebhj.apps.googleusercontent.com',
    iosBundleId: 'com.example.sabSunno',
  );
}
