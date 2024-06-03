import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taska/utils/constants.dart';

extension DateTimeExtension on DateTime {
  DateTime startOfDay() => DateTime(year, month, day);

  String formatDate([String pattern = kdfTaskDate]) =>
      DateFormat(pattern).format(this);

  DateTime addYears(int years) {
    return copyWith(year: year + years);
  }

  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);

  DateTime addTimeOfDay(TimeOfDay time) {
    return copyWith(hour: time.hour, minute: time.minute);
  }
}
