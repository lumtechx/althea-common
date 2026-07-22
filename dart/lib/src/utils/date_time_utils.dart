class DateTimeUtils {
  /// Dynamically parses various date representations into a [DateTime].
  /// Supports [DateTime], [String] (ISO 8601), [int] (milliseconds since epoch),
  /// and Firestore `Timestamp` objects (invoking `.toDate()` dynamically).
  static DateTime? parse(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);

    // Check for Firestore Timestamp or other objects with toDate() dynamically
    try {
      return value.toDate();
    } catch (_) {
      // Ignore conversion failures and try parsing string representation
    }

    try {
      return DateTime.tryParse(value.toString());
    } catch (_) {
      // Ignore
    }

    return null;
  }
}
