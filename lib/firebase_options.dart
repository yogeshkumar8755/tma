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
    apiKey: 'AIzaSyBrs9r9PT_EGXv8sLorzo_E5RlQavWAle4',
    appId: '1:213892683495:web:310e1beffdfc3454c63442',
    messagingSenderId: '213892683495',
    projectId: 'we-chet',
    authDomain: 'we-chet.firebaseapp.com',
    storageBucket: 'we-chet.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBe6D9sxGivwcRK8ZbS2HcB2BUejiUfOIw',
    appId: '1:213892683495:android:261c9ebdf6a746f1c63442',
    messagingSenderId: '213892683495',
    projectId: 'we-chet',
    storageBucket: 'we-chet.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRFHopmvIhpmYZdw8h21NssKv8LI_ceNs',
    appId: '1:213892683495:ios:5e1bdfb2d9c11dbfc63442',
    messagingSenderId: '213892683495',
    projectId: 'we-chet',
    storageBucket: 'we-chet.firebasestorage.app',
    iosBundleId: 'com.example.tma',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRFHopmvIhpmYZdw8h21NssKv8LI_ceNs',
    appId: '1:213892683495:ios:5e1bdfb2d9c11dbfc63442',
    messagingSenderId: '213892683495',
    projectId: 'we-chet',
    storageBucket: 'we-chet.firebasestorage.app',
    iosBundleId: 'com.example.tma',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBL-b08650nRQT8zjddOZ2plbmgyjGoIwI',
    appId: '1:213892683495:web:5b54b301c003a2dcc63442',
    messagingSenderId: '213892683495',
    projectId: 'we-chet',
    authDomain: 'we-chet.firebaseapp.com',
    storageBucket: 'we-chet.firebasestorage.app',
  );

}