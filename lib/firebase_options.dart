// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCs4WR9qTVA3C8cB8sAOdk7iu6TMFlEXRE',
    appId: '1:13350014563:web:38c71ee345536a009e7256',
    messagingSenderId: '13350014563',
    projectId: 'schroom-9b2c6',
    authDomain: 'schroom-9b2c6.firebaseapp.com',
    databaseURL: 'https://schroom-9b2c6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'schroom-9b2c6.appspot.com',
    measurementId: 'G-NDK1QXEM22',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3TXRtQd0RFmftazpHHDpJTUnsy9bfbE0',
    appId: '1:13350014563:android:39d0f61c13455f8d9e7256',
    messagingSenderId: '13350014563',
    projectId: 'schroom-9b2c6',
    databaseURL: 'https://schroom-9b2c6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'schroom-9b2c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4I0mn_Bd72slK2xeBVjqImf_A_GxJ2i0',
    appId: '1:13350014563:ios:cd20a9e6a08b82da9e7256',
    messagingSenderId: '13350014563',
    projectId: 'schroom-9b2c6',
    databaseURL: 'https://schroom-9b2c6-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'schroom-9b2c6.appspot.com',
    androidClientId: '13350014563-2v7mf90uiqeioeo9hn5clb0mpe6t7dit.apps.googleusercontent.com',
    iosClientId: '13350014563-htp65k7necr0of5u7sqh1splcjh7adlk.apps.googleusercontent.com',
    iosBundleId: 'com.example.senceSence',
  );
}
