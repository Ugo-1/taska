import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/services/task_service.dart';

mixin CreateTaskMixin {
  /// If the task being created or edited overlaps with an existing task.
  ///
  /// [taskId] is only non null if its an edit operation
  (bool, TaskModel?) isTaskOverlapping({
    required DateTime startDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required List<int> taskFrequency,
    int? taskId,
  }) {
    final TaskService taskService = locator<TaskService>();
    final List<TaskModel> savedTasks = List.from(taskService.tasks.value);
    // Removes the task being edited
    if (taskId != null) {
      savedTasks.removeWhere((element) => element.id == taskId);
    }
    final int weekday = startDate.weekday;
    final List<int> frequency = taskFrequency.contains(weekday)
        ? taskFrequency
        : List.from(taskFrequency)
      ..add(weekday);
    for (TaskModel task in savedTasks) {
      final bool sameDay = isSameDay(task.startDate, startDate);
      final bool hasSameFrequency =
          frequency.any((day) => task.taskFrequency.contains(day));
      if (sameDay || hasSameFrequency) {
        final bool endIsBeforeOrEqualStart =
            endTime.isBeforeOrEquals(task.startTime);
        final bool startIsAfterOrEqualEnd =
            startTime.isAfterOrEquals(task.endTime);
        if (!(endIsBeforeOrEqualStart || startIsAfterOrEqualEnd)) {
          if (task.endDate != null && task.endDate!.isBefore(startDate)) {
            continue;
          } else {
            return (false, task);
          }
        }
      }
    }
    return (true, null);
  }
}
