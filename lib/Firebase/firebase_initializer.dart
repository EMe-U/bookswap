// Platform-conditional Firebase initializer.
// This file selects the correct implementation at compile-time:
// - On IO (Android/iOS) it imports the mobile initializer that calls
//   Firebase.initializeApp() (and thus depends on firebase_core).
// - On Web it imports a lightweight stub that does nothing, avoiding
//   firebase_web interop compilation issues when you only want stubs.

import 'firebase_initializer_stub.dart'
    if (dart.library.io) 'firebase_initializer_mobile.dart'
    if (dart.library.html) 'firebase_initializer_web.dart';

/// Initialize Firebase for the current platform.
/// This resolves to a no-op on web (stub) and to a real init on mobile.
Future<void> initializeFirebase() => firebaseInitialize();
