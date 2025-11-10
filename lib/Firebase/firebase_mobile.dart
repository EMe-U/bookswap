// Mobile-only re-export of Firebase SDK packages used across the app.
// This file is imported via conditional imports so it only appears on IO
// (Android/iOS) builds. It re-exports the real firebase packages the app
// uses.

export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_storage/firebase_storage.dart';
