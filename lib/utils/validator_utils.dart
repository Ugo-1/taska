import 'package:flutter/material.dart';
import 'package:taska/extensions/time_of_day_extension.dart';

class ValidatorUtils {
  static String? validateEmpty(String? value) {
    return (value?.isEmpty ?? true) ? 'This field cannot be empty' : null;
  }

  static String? validateStartTime(TimeOfDay? startTime, DateTime? startDate) {
    if (startTime == null) {
      return 'This field cannot be empty';
    }
    final DateTime now = DateTime.now();
    DateTime startDateTime;

    if (startDate == null) {
      startDateTime = startTime.toDateTime();
    } else {
      startDateTime =
          startDate.copyWith(hour: startTime.hour, minute: startTime.minute);
    }

    return (startDateTime.isAfter(now))
        ? null
        : 'Start time must be after current time';
  }

  static String? validateEndDate(DateTime? startDate, TimeOfDay? startTime,
      DateTime? endDate, TimeOfDay? endTime) {
    if (startDate == null || startTime == null || endDate == null) {
      return null;
    }
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime;

    if (endTime != null) {
      endDateTime = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      );
    } else {
      endDateTime = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        startTime.hour,
        startTime.minute,
      );
    }

    return (endDateTime.isAfter(startDateTime))
        ? null
        : 'End date must be after the start date';
  }

  static String? validateEndTime(DateTime? startDate, TimeOfDay? startTime,
      DateTime? endDate, TimeOfDay? endTime) {
    if (endTime == null) {
      return 'This field cannot be empty';
    }
    if (startDate == null || startTime == null) {
      return null;
    }

    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime;

    if (endDate != null) {
      endDateTime = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      );
    } else {
      endDateTime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        endTime.hour,
        endTime.minute,
      );
    }

    return (endDateTime.isAfter(startDateTime))
        ? null
        : 'End time must be after the start time';
  }
}
