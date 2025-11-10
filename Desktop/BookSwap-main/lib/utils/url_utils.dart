/// Utilities for validating URLs used by network images.
bool isValidHttpUrl(String? url) {
  if (url == null) return false;
  final trimmed = url.trim();
  if (trimmed.isEmpty) return false;
  try {
    final uri = Uri.parse(trimmed);
    if (!uri.hasScheme) return false;
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https' || scheme == 'data';
  } catch (e) {
    return false;
  }
}
