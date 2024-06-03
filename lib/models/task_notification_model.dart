import 'package:flutter/material.dart';
import 'package:taska/models/task_model.dart';

class TaskNotificationModel {
  final int id;
  final String taskName, description;
  final DateTime startDate;
  final TimeOfDay startTime, endTime;
  final List<int> taskFrequency;
  final List<int> taskFrequencyId;

  DateTime get startDateTime => DateTime(startDate.year, startDate.month,
      startDate.day, startTime.hour, startTime.minute);

  const TaskNotificationModel({
    required this.taskName,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.taskFrequency,
    required this.id,
    required this.taskFrequencyId,
  });

  factory TaskNotificationModel.fromTaskModel(TaskModel task) {
    return TaskNotificationModel(
      taskName: task.taskName,
      description: task.description,
      startDate: task.startDate,
      startTime: task.startTime,
      endTime: task.endTime,
      taskFrequency: task.taskFrequency,
      taskFrequencyId: task.taskFrequencyId,
      id: task.id,
    );
  }
}
