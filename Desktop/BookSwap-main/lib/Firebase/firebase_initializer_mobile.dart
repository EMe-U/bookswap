// Mobile (IO) implementation that initializes Firebase using the
// generated `firebase_options.dart` file. This file imports the
// real `firebase_core` package and will only be compiled for IO
// (Android/iOS), not for web.

import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

Future<void> firebaseInitialize() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
