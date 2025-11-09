//
//Bookswap - main.dart
//
// This is the entry point of the BookSwap application.
//
// app architecture:
// - State Management: Flutter Riverpod (ProviderScope wraps entire app)
// - Navigation: Named routes (see routes/routes.dart)
// - Authentication: Firebase Auth (handled by AuthWrapper)
// - Database: Cloud Firestore
// - Storage: Firebase Storage (for book covers and profile pictures)
// - Notifications: Local notifications (flutter_local_notifications)
//
// flow:
// 1. Initialize Firebase
// 2. Initialize Notification Service
// 3. Wrap app in ProviderScope (for Riverpod state management)
// 4. MaterialApp uses named routes for navigation
// 5. AuthWrapper determines which screen to show based on auth state
//
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookswap/routes/routes.dart';
import 'package:bookswap/Services/notification_service.dart';
import 'Firebase/firebase_initializer.dart';

// Toggle between stubs and real Firebase implementation.
// runtime config removed — keep stubs mode by default

// Main entry point of the application
//
// Initialization order:
// 1. Ensure Flutter bindings are initialized (required for async operations)
// 2. Initialize Firebase (database, auth, storage)
// 3. Initialize Notification Service (for local push notifications)
// 4. Run the app wrapped in ProviderScope (Riverpod state management)
void main() async {
  // Required for async operations before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization removed — the project now uses local stubs.
  // Replace with your own Firebase initialization if needed (see README
  // or re-enable via a guarded initialization that imports the SDKs).
  // Initialize Firebase conditionally (no-op on web if using stubs)
  try {
    await initializeFirebase();
    debugPrint('initializeFirebase() completed');
  } catch (e) {
    debugPrint('initializeFirebase() error: $e');
  }

  // Initialize local notification service (for push notifications)
  try {
    await NotificationService().initialize();
    debugPrint('Notification service initialized successfully');
  } catch (e) {
    debugPrint('Notification service initialization error: $e');
  }

  // Run the app wrapped in ProviderScope for Riverpod state management
  runApp(const ProviderScope(child: MyApp()));
}

// Root widget of the application
//
// Sets up:
// - Material Design theme
// - Named route navigation (see routes/routes.dart)
// - Initial route (login screen)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookSwap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 29, 78, 255),
        ),
      ),
      // Start at login screen
      initialRoute: AppRoutes.login,
      // Use named routes for navigation (defined in routes/routes.dart)
      onGenerateRoute: generateRoute,
    );
  }
}
