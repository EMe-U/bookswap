// Utilities for robustly parsing timestamp-like values coming from
// either Firestore (Timestamp), local stubs, or raw DateTime/int values.

DateTime parseTimestamp(dynamic value) {
  if (value == null) return DateTime.now();

  // Already a DateTime
  if (value is DateTime) return value;

  // If it's an int (millisecondsSinceEpoch)
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);

  // Try calling toDate() on the object (Firestore Timestamp or stub with same API)
  try {
    final maybe = (value as dynamic).toDate();
    if (maybe is DateTime) return maybe;
  } catch (_) {
    // ignore and continue
  }

  // If it has a seconds/epoch field
  try {
    if (value is Map) {
      if (value['seconds'] != null) {
        final s = value['seconds'];
        final ms = (s is int) ? s * 1000 : int.tryParse(s.toString()) ?? 0;
        return DateTime.fromMillisecondsSinceEpoch(ms);
      }
    }
  } catch (_) {}

  // Fallback
  return DateTime.now();
}
