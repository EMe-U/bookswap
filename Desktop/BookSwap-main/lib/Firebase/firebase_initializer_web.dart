// Web-specific initializer: initialize Firebase for web builds.
// This will call Firebase.initializeApp using the generated firebase options.
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

Future<void> firebaseInitialize() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If initialization fails, surface a debug message but don't crash the app here.
    // Caller can decide how to handle initialization errors.
    // On web, missing or misconfigured firebase options will throw here.
    // Keep it minimal so developers can opt into real Firebase on web.
    // ignore: avoid_print
    print('Firebase web initialization failed: $e');
  }
}
