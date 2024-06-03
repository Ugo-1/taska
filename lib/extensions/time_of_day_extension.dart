import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeFormatExtension on TimeOfDay {
  DateTime toDateTime() {
    return DateTime.now().copyWith(hour: hour, minute: minute);
  }

  String toLocaleTime() {
    return DateFormat.jm().format(toDateTime());
  }

  int toMinutes() {
    return hour * 60 + minute;
  }

  bool isBefore(TimeOfDay other) {
    return (toMinutes() < other.toMinutes()) ? true : false;
  }

  bool isBeforeOrEquals(TimeOfDay other) {
    return (toMinutes() <= other.toMinutes()) ? true : false;
  }

  bool isAfter(TimeOfDay other) {
    return !isBefore(other) && this != other;
  }

  bool isAfterOrEquals(TimeOfDay other) {
    return (toMinutes() >= other.toMinutes()) ? true : false;
  }

  /// The difference between 2 time of days. This returns the difference in
  /// minutes
  int difference(TimeOfDay other) {
    return toMinutes() - other.toMinutes();
  }
}
