import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taska/extensions/date_time_extension.dart';
import 'package:taska/extensions/int_extension.dart';
import 'package:taska/extensions/time_of_day_extension.dart';
import 'package:taska/models/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

extension TaskExtension on List<TaskModel> {
  List<TaskModel> getTasksForDay(DateTime dateTime) {
    final List<TaskModel> tasks = where(
      (task) {
        final int weekday = dateTime.weekday;
        // Check if its before the start date
        if (dateTime.startOfDay().isBefore(task.startDate.startOfDay())) {
          return false;
        }

        // If the end date is before the selected date time
        if (task.endDate != null &&
            task.endDate!.startOfDay().isBefore(dateTime.startOfDay())) {
          return false;
        }

        // Check if its the same day
        if (isSameDay(dateTime, task.startDateTime)) {
          return true;
        }

        // Check schedule
        if (task.taskFrequency.isNotEmpty) {
          if (task.taskFrequency.contains(weekday)) {
            return true;
          }
        }
        return false;
      },
    ).toList();
    tasks.sort();
    return tasks;
  }

  /// This results in the current tasks for the day
  List<TaskModel> getDayCurrentTasks(DateTime dateTime) {
    final List<TaskModel> newList = List.from(this);
    return newList.where((task) {
      final today = DateTime.now();
      // For today tasks
      if (isSameDay(dateTime, today)) {
        return task.endTime.isAfter(TimeOfDay.fromDateTime(today));
      }
      // If the date is before today then its not current
      else if (dateTime.isBefore(today)) {
        return false;
      }
      // Here the date is after and hence a current day
      else {
        return true;
      }
    }).toList();
  }

  /// This results in the tasks completed/passed for the day
  List<TaskModel> getDayPastTasks(
      DateTime dateTime, List<TaskModel> currentTasks) {
    final List<TaskModel> newList = List.from(this);
    return newList.where((element) => !currentTasks.contains(element)).toList();
  }
}

extension ListIntExtension on List<int> {
  String getTaskFrequency([bool useShortForm = false]) {
    final List<int> weekdays = List.generate(7, (index) => index + 1);
    final bool isEmpty = this.isEmpty;
    final bool isFull = length == 7;
    final bool isWeekdays = listEquals(weekdays.take(5).toList(), this);
    final bool isWeekend = listEquals(weekdays.sublist(5), this);
    return isEmpty
        ? 'No repeat'
        : isFull
            ? 'Everyday'
            : isWeekdays
                ? 'Weekdays'
                : isWeekend
                    ? 'Weekends'
                    : 'Every ${getTaskFrequencyDays(useShortForm ? 'E' : 'EEEE')}';
  }

  String getTaskFrequencyDays([String pattern = 'EEEE']) {
    return map((weekday) => weekday.getDayOfWeekText(pattern)).join(', ');
  }
}
