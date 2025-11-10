// Minimal Firebase stubs to allow the app to compile without real Firebase.
// Replace these with your own Firebase implementation when ready.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// Minimal User model used across the app (replace with firebase_auth.User)
class User {
  final String uid;
  String? email;
  String? displayName;
  String? photoURL;
  bool emailVerified;

  User({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.emailVerified = false,
  });

  Future<void> reload() async {
    // No-op stub
    await Future<void>.value();
  }

  Future<void> sendEmailVerification() async {
    // For testing, immediately mark as verified
    emailVerified = true;
    await Future<void>.value();
  }

  Future<void> updateDisplayName(String? name) async {
    displayName = name;
    await Future<void>.value();
  }

  Future<void> updatePhotoURL(String? url) async {
    photoURL = url;
    await Future<void>.value();
  }

  Future<String> getIdToken(bool refresh) async {
    return Future.value('');
  }
}

/// Minimal UserCredential stub
class UserCredential {
  final User? user;
  UserCredential({this.user});
}

/// Minimal FirebaseAuth stub
class FirebaseAuth {
  FirebaseAuth._internal();
  static final FirebaseAuth instance = FirebaseAuth._internal();

  User? currentUser;

  final StreamController<User?> _userController =
      StreamController<User?>.broadcast();

  Stream<User?> authStateChanges() => _userController.stream;
  Stream<User?> userChanges() => _userController.stream;

  // In-memory user store for testing
  final Map<String, String> _passwords = {};
  final Map<String, User> _usersByEmail = {};
  int _uidCounter = 1000;

  // Sign in: check in-memory store
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final key = email.toLowerCase();
    final stored = _passwords[key];
    if (stored == null) {
      throw 'user-not-found';
    }
    if (stored != password) {
      throw 'wrong-password';
    }
    // Return existing user
    final user = _usersByEmail[key]!;
    currentUser = user;
    _userController.add(currentUser);
    return UserCredential(user: user);
  }

  // Create user (sign up)
  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final key = email.toLowerCase();
    if (_passwords.containsKey(key)) {
      throw 'email-already-in-use';
    }
    final uid = 'uid_${_uidCounter++}';
    final user = User(
      uid: uid,
      email: email,
      displayName: '',
      photoURL: null,
      emailVerified: false,
    );
    _passwords[key] = password;
    _usersByEmail[key] = user;
    currentUser = user;
    _userController.add(currentUser);
    return UserCredential(user: user);
  }

  Future<void> signOut() async {
    currentUser = null;
    _userController.add(null);
  }
}

/// Minimal FirebaseStorage stub
class FirebaseStorage {
  FirebaseStorage._internal();
  static FirebaseStorage instance = FirebaseStorage._internal();

  factory FirebaseStorage.instanceFor({String? bucket}) => instance;
  Reference ref() => Reference();

  Reference refFromURL(String url) => Reference();
}

class Reference {
  Reference child(String path) => this;

  // putFile returns a Future<TaskSnapshot> (UploadTask)
  // Accepts either a File (mobile) or Uint8List (web) for testing
  UploadTask putFile(dynamic file, [SettableMetadata? metadata]) async {
    int bytes = 0;
    try {
      if (file == null) {
        bytes = 0;
      } else if (file is File) {
        bytes = file.lengthSync();
      } else if (file is Uint8List) {
        bytes = file.length;
      } else if (file is List<int>) {
        bytes = file.length;
      }
    } catch (_) {
      bytes = 0;
    }

    return TaskSnapshot(bytesTransferred: bytes, totalBytes: bytes);
  }

  // Return a placeholder image URL when no real URL is available so
  // Image.network calls on the web do not fail with "Invalid URL".
  Future<String> getDownloadURL() async =>
      Future.value('https://picsum.photos/200/300');

  Future<void> delete() async => Future.value();
}

// In code the UploadTask is awaited and whenComplete() is called. Use a
// typedef to make UploadTask a Future<TaskSnapshot> so it behaves like a
// normal Future and supports whenComplete(), then(), await, etc.
typedef UploadTask = Future<TaskSnapshot>;

class TaskSnapshot {
  // Provide commonly used fields
  final int bytesTransferred;
  final int totalBytes;

  TaskSnapshot({this.bytesTransferred = 0, this.totalBytes = 0});
}

class SettableMetadata {
  final String? contentType;
  final Map<String, String>? customMetadata;
  SettableMetadata({this.contentType, this.customMetadata});
}
