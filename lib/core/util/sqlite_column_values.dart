// Conversions between SQLite column values and Dart types.
bool sqliteBoolFromColumn(final Object? value) {
  if (value == null) {
    return false;
  }
  if (value is bool) {
    return value;
  }
  if (value is int) {
    return value != 0;
  }
  if (value is num) {
    return value != 0;
  }
  return false;
}

int sqliteBoolToColumn(final bool value) => value ? 1 : 0;

String sqliteDateTimeToColumn(final DateTime value) =>
    value.toIso8601String();

DateTime sqliteDateTimeFromColumn(final Object? value) {
  if (value is DateTime) {
    return value;
  }
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  throw FormatException('Expected ISO-8601 datetime string, got: $value');
}

DateTime? sqliteDateTimeFromColumnNullable(final Object? value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  return null;
}

String intToStringColumn(final int value) => value.toString();

int intFromColumn(final Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  throw FormatException('Expected int-compatible value, got: $value');
}

double doubleFromColumn(final Object? value) {
  if (value is double) {
    return value;
  }
  if (value is int) {
    return value.toDouble();
  }
  if (value is num) {
    return value.toDouble();
  }
  throw FormatException('Expected double-compatible value, got: $value');
}

String stringFromColumn(final Object? value) {
  if (value is String) {
    return value;
  }
  throw FormatException('Expected String, got: $value');
}

String? stringFromColumnNullable(final Object? value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    return value;
  }
  return value.toString();
}
