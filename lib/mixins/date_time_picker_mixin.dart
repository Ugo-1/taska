import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taska/extensions/context_extension.dart';
import 'package:taska/extensions/time_of_day_extension.dart';

mixin DateTimePickerMixin {
  void showAdaptiveDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    required ValueChanged<DateTime> onDateChanged,
    DateTime? initialDate,
  }) {
    final bool isIos = context.isIOSPlatform();
    final DateTime today = DateTime.now();
    if (initialDate != null && initialDate.isBefore(today)){
      initialDate = today;
    }
    if (isIos) {
      return _showCupertinoDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        onDateChanged: onDateChanged,
        initialDate: initialDate,
      );
    } else {
      return _showMaterialDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        onDateChanged: onDateChanged,
        initialDate: initialDate,
      );
    }
  }

  void _showMaterialDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    required ValueChanged<DateTime> onDateChanged,
    DateTime? initialDate,
  }) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateTime != null) {
      onDateChanged(dateTime);
    }
    return;
  }

  void _showCupertinoDatePicker({
    required BuildContext context,
    required DateTime firstDate,
    required DateTime lastDate,
    required ValueChanged<DateTime> onDateChanged,
    DateTime? initialDate,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (BuildContext builder) {
        return Container(
          height: context.heightPercent(30),
          color: context.colors.background,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: onDateChanged,
            initialDateTime: initialDate,
            minimumDate: firstDate,
            maximumDate: lastDate,
          ),
        );
      },
    );
  }

  void showAdaptiveTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onTimeChanged,
  }) {
    final bool isIos = context.isIOSPlatform();
    return (isIos)
        ? _showCupertinoTimePicker(
            context: context,
            initialTime: initialTime,
            onTimeChanged: onTimeChanged,
          )
        : _showMaterialTimePicker(
            context: context,
            initialTime: initialTime,
            onTimeChanged: onTimeChanged,
          );
  }

  void _showMaterialTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onTimeChanged,
  }) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (timeOfDay != null) {
      onTimeChanged(timeOfDay);
    }
    return;
  }

  void _showCupertinoTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onTimeChanged,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (BuildContext builder) {
        return Container(
          height: context.heightPercent(30),
          color: context.colors.background,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
            onDateTimeChanged: (dateTime) =>
                onTimeChanged(TimeOfDay.fromDateTime(dateTime)),
            initialDateTime: initialTime.toDateTime(),
          ),
        );
      },
    );
  }
}
