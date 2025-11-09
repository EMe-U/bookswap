import 'package:bookswap/stubs/firebase_stubs.dart'
    if (dart.library.io) 'package:firebase_auth/firebase_auth.dart';

// AuthService now uses the real firebase_auth package on platforms where
// Firebase is enabled (mobile). This keeps the same method names so callers
// in the app don't need large changes.

class AuthService {
  // Lazy initialization of FirebaseAuth to avoid errors if Firebase isn't initialized
  FirebaseAuth? _auth;

  FirebaseAuth get auth {
    _auth ??= FirebaseAuth.instance;
    return _auth!;
  }

  // Get current user
  User? get currentUser {
    try {
      return auth.currentUser;
    } catch (e) {
      return null;
    }
  }

  // Auth state changes stream - returns the underlying auth stream (stubbed)
  Stream<User?> get authStateChanges {
    try {
      return auth.authStateChanges();
    } catch (e) {
      return Stream.value(null);
    }
  }

  // User changes stream
  Stream<User?> get userChanges {
    try {
      return auth.userChanges();
    } catch (e) {
      return Stream.value(null);
    }
  }

  // Check if user is logged in
  bool get isLoggedIn {
    return currentUser != null;
  }

  // Sign up with email and password
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential != null) {
      final u = userCredential.user;
      if (u != null && (firstName != null || lastName != null)) {
        final displayName = [
          firstName,
          lastName,
        ].where((n) => n != null && n.isNotEmpty).join(' ');
        if (displayName.isNotEmpty) {
          await u.updateDisplayName(displayName);
          await u.reload();
        }
      }
    }

    // firebase_auth returns a non-null UserCredential on success. Keep
    // the nullable return type for compatibility with existing callers.
    return userCredential;
  }

  // Sign in with email and password
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential != null) {
      final u = userCredential.user;
      if (u != null) {
        await u.reload();
        await u.getIdToken(true);
      }
    }

    return userCredential;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      // no-op
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      // ignore
    }
  }

  // Resend email verification
  Future<void> resendVerificationEmail() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      // ignore
    }
  }

  // Check if current user's email is verified
  bool isEmailVerified() {
    final user = currentUser;
    return user?.emailVerified ?? false;
  }

  // Reload user to check latest verification status
  Future<void> reloadUser() async {
    try {
      await auth.currentUser?.reload();
    } catch (e) {
      // no-op
    }
  }

  // No-op: auth exception handling is not implemented in the stub.
}
