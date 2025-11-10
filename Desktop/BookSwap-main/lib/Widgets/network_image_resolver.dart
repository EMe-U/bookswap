import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bookswap/utils/url_utils.dart';

/// Widget that accepts a stored image URL (either http(s) or gs://) and
/// resolves it to a usable download URL for Image.network. Falls back to a
/// placeholder when resolution fails.
class NetworkImageResolver extends StatelessWidget {
  final String? storedUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const NetworkImageResolver({
    Key? key,
    required this.storedUrl,
    this.width = 60,
    this.height = 90,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  Future<String?> _resolveUrl() async {
    final url = storedUrl;
    if (url == null || url.trim().isEmpty) return null;
    final trimmed = url.trim();

    // If it's already a valid http/https/data URL, return it
    if (isValidHttpUrl(trimmed)) return trimmed;

    // If it's a gs:// Firebase Storage URL, resolve to download URL
    if (trimmed.startsWith('gs://')) {
      try {
        final ref = FirebaseStorage.instance.refFromURL(trimmed);
        final download = await ref.getDownloadURL();
        return download;
      } catch (e) {
        // resolution failed
        return null;
      }
    }

    // Not a supported URL
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _resolveUrl(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final resolved = snap.data;
        if (resolved == null || resolved.isEmpty) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 30, color: Colors.grey),
          );
        }

        return Image.network(
          resolved,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                size: 30,
                color: Colors.grey,
              ),
            );
          },
        );
      },
    );
  }
}
