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
    apiKey: 'AIzaSyDJlShCPdEwxoRjeqq2PE_EwCV-tW98lzA',
    appId: '1:276481318857:web:3780031cd74645ec84d218',
    messagingSenderId: '276481318857',
    projectId: 'antam-today',
    authDomain: 'antam-today.firebaseapp.com',
    databaseURL: 'https://antam-today.firebaseio.com',
    storageBucket: 'antam-today.appspot.com',
    measurementId: 'G-P6T4GQ3Y1X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-z13gyFLIbesZ_noL_KwY-9cysk4Wf90',
    appId: '1:276481318857:android:19e596e8f9381cc684d218',
    messagingSenderId: '276481318857',
    projectId: 'antam-today',
    databaseURL: 'https://antam-today.firebaseio.com',
    storageBucket: 'antam-today.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDc0EgZoy5LRIB2r1ucpiPs_muNX-2qpXY',
    appId: '1:276481318857:ios:4944c5952c5c712784d218',
    messagingSenderId: '276481318857',
    projectId: 'antam-today',
    databaseURL: 'https://antam-today.firebaseio.com',
    storageBucket: 'antam-today.appspot.com',
    androidClientId: '276481318857-bh7ots3pf9gotogn2dnr19d1dhh3bdn9.apps.googleusercontent.com',
    iosBundleId: 'com.softcomfy.uninote',
  );

}