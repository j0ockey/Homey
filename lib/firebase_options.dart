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
    apiKey: 'AIzaSyDEmfnBwMzZH_AUkpgpG_EmKdmQGw4PpjM',
    appId: '1:264782078723:web:d6535df90c1baaf6553f36',
    messagingSenderId: '264782078723',
    projectId: 'homey-83866',
    authDomain: 'homey-83866.firebaseapp.com',
    storageBucket: 'homey-83866.appspot.com',
    measurementId: 'G-7CD7NH90MK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPfndp-yu-3BO2YMIo2exy-Z3vED5eO64',
    appId: '1:264782078723:android:3646ebe14e053b9c553f36',
    messagingSenderId: '264782078723',
    projectId: 'homey-83866',
    storageBucket: 'homey-83866.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtaIe_A2HEToKMUkQU7n-ibe0T1HuyFws',
    appId: '1:264782078723:ios:34717a2ba6b14e2a553f36',
    messagingSenderId: '264782078723',
    projectId: 'homey-83866',
    storageBucket: 'homey-83866.appspot.com',
    iosBundleId: 'com.example.homey',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtaIe_A2HEToKMUkQU7n-ibe0T1HuyFws',
    appId: '1:264782078723:ios:34717a2ba6b14e2a553f36',
    messagingSenderId: '264782078723',
    projectId: 'homey-83866',
    storageBucket: 'homey-83866.appspot.com',
    iosBundleId: 'com.example.homey',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEmfnBwMzZH_AUkpgpG_EmKdmQGw4PpjM',
    appId: '1:264782078723:web:34ef08855f5e6d08553f36',
    messagingSenderId: '264782078723',
    projectId: 'homey-83866',
    authDomain: 'homey-83866.firebaseapp.com',
    storageBucket: 'homey-83866.appspot.com',
    measurementId: 'G-E18ZHPKMNL',
  );

}