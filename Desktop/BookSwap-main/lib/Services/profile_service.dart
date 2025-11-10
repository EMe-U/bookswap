import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

/// Service for managing user profile pictures
class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Use default storage instance configured by Firebase options
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload profile picture
  Future<String> uploadProfilePicture(dynamic imageFile) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw 'You must be logged in to upload a profile picture';
    }

    try {
      debugPrint('Starting profile picture upload...');

      // Create a unique filename
      final String fileName =
          'profile_pictures/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      debugPrint('📁 File path: $fileName');

      final Reference storageRef = _storage.ref().child(fileName);

      // Upload metadata
      final SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'uploadedBy': user.uid,
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      debugPrint('Uploading profile picture...');

      // Support both bytes (web) and File (mobile)
      late final UploadTask uploadTask;
      if (imageFile is Uint8List || imageFile is List<int>) {
        uploadTask = storageRef.putData(
          imageFile is Uint8List
              ? imageFile
              : Uint8List.fromList(imageFile as List<int>),
          metadata,
        );
      } else {
        // Assume a File-like object on mobile
        uploadTask = storageRef.putFile(imageFile, metadata);
      }

      await uploadTask;
      debugPrint('Profile picture uploaded successfully');

      // Get download URL
      final String downloadUrl = await storageRef.getDownloadURL();
      debugPrint('Profile picture URL: $downloadUrl');

      // Update user's photoURL in Firebase Auth
      await user.updatePhotoURL(downloadUrl);
      await user.reload();

      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading profile picture: $e');
      throw 'Failed to upload profile picture: $e';
    }
  }

  /// Delete profile picture
  Future<void> deleteProfilePicture() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw 'You must be logged in to delete a profile picture';
    }

    try {
      // Remove photoURL from user
      await user.updatePhotoURL(null);
      await user.reload();

      // Note: We don't delete from Storage automatically to avoid breaking references
      // You can add cleanup logic if needed
    } catch (e) {
      throw 'Failed to delete profile picture: $e';
    }
  }
}
