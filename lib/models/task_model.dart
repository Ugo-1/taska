import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/enums/colors_enum.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/extensions/time_of_day_extension.dart';

class TaskModel extends Equatable implements Comparable<TaskModel> {
  final String taskName, description;
  final DateTime startDate;
  final DateTime? endDate;
  final TimeOfDay startTime, endTime;
  final List<int> taskFrequency;
  final List<int> taskFrequencyId;
  final ColorsEnum color;
  final int id;
  final List<ChecklistModel> checklist;

  DateTime get startDateTime => DateTime(startDate.year, startDate.month,
      startDate.day, startTime.hour, startTime.minute);

  List<int> get ids => [id, ...taskFrequencyId];

  // If the task has started
  bool get hasStarted {
    final now = TimeOfDay.fromDateTime(DateTime.now());
    return isTodayTask &&
        startTime.isBeforeOrEquals(now) &&
        (endTime.isAfter(now));
  }

  /// If the task is scheduled for today
  bool get isTodayTask{
    final DateTime today = DateTime.now();
    return (isSameDay(today, startDate) ||
        taskFrequency.contains(today.weekday)) &&
        (endDate?.isAfter(today) ?? true);
  }

  /// If its an upcoming task today
  bool get isTodayCurrentTask {
    final DateTime today = DateTime.now();
    return isTodayTask &&
        endTime.isAfterOrEquals(TimeOfDay.fromDateTime(today));
  }

  const TaskModel({
    required this.id,
    required this.taskName,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.startTime,
    required this.endTime,
    this.taskFrequency = const [],
    this.taskFrequencyId = const [],
    required this.color,
    this.checklist = const [],
  }) : assert(taskFrequency.length == taskFrequencyId.length);

  @override
  List<Object?> get props => [
        id,
        taskName,
        description,
        startDateTime,
        endDate,
        endTime,
        taskFrequency,
        color,
        checklist,
      ];

  // Custom comparison method for sorting tasks by start date and time
  @override
  int compareTo(TaskModel other) {
    final DateTime thisTime = startTime.toDateTime();
    final DateTime otherTime = other.startTime.toDateTime();
    if (thisTime.isBefore(otherTime)) {
      return -1;
    } else if (thisTime.isAfter(otherTime)) {
      return 1;
    }
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime.toDateTime(),
      'endTime': endTime.toDateTime(),
      'taskFrequency': taskFrequency,
      'taskFrequencyId': taskFrequencyId,
      'color': color.name,
      'id': id,
      'checklist': checklist.map((e) => e.toJson()).toList(),
    };
  }

  factory TaskModel.fromJson(Map<dynamic, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as DateTime,
      endDate: json['endDate'] as DateTime?,
      startTime: TimeOfDay.fromDateTime(json['startTime']),
      endTime: TimeOfDay.fromDateTime(json['endTime']),
      taskFrequency: json['taskFrequency'] as List<int>,
      taskFrequencyId: json['taskFrequencyId'] as List<int>,
      color: ColorsEnum.values.byName(json['color'] as String),
      id: json['id'] as int,
      checklist: (json['checklist'] as List)
          .map((e) => ChecklistModel.fromJson(e))
          .toList(),
    );
  }

  TaskModel copyWith({
    String? taskName,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<int>? taskFrequency,
    List<int>? taskFrequencyId,
    ColorsEnum? color,
    List<ChecklistModel>? checklist,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      taskFrequency: taskFrequency ?? this.taskFrequency,
      taskFrequencyId: taskFrequencyId ?? this.taskFrequencyId,
      color: color ?? this.color,
      id: id,
      checklist: checklist ?? this.checklist,
    );
  }

  double getTaskProgress() {
    if (!hasStarted) return 0;
    final now = TimeOfDay.fromDateTime(DateTime.now());
    final totalDuration = endTime.difference(startTime);

    final elapsedDuration = now.isAfterOrEquals(endTime)
        ? totalDuration
        : now.difference(startTime);

    final progress = elapsedDuration / totalDuration;
    return progress.clamp(0.0, 1.0); // Clamp between 0.0 and 1.0 for percentage
  }

  @override
  String toString() {
    return 'TaskModel{\n'
        ' taskName: $taskName,\n'
        ' description: $description,\n'
        ' startDate: $startDate,\n'
        ' endDate: $endDate,\n'
        ' startTime: $startTime,\n'
        ' endTime: $endTime,\n'
        ' taskFrequency: $taskFrequency,\n'
        ' taskFrequencyId: $taskFrequencyId,\n'
        ' color: $color,\n'
        ' id: $id,\n'
        ' checklist: $checklist\n'
        '}';
  }
}

class ChecklistModel {
  final String checklist;
  final bool checked;
  final DateTime? dateChecked;

  bool get wasCheckedToday =>
      dateChecked != null && isSameDay(DateTime.now(), dateChecked!);

  const ChecklistModel({
    required this.checklist,
    this.checked = false,
    this.dateChecked,
  });

  Map<String, dynamic> toJson() {
    return {
      'checklist': checklist,
      'checked': checked,
      'dateChecked': dateChecked,
    };
  }

  factory ChecklistModel.fromJson(Map<dynamic, dynamic> json) {
    return ChecklistModel(
      checklist: json['checklist'] as String,
      checked: json['checked'] as bool,
      dateChecked: json['dateChecked'] as DateTime?,
    );
  }

  ChecklistModel copyWith({
    String? checklist,
    bool? checked,
    DateTime? dateChecked,
  }) {
    return ChecklistModel(
      checklist: checklist ?? this.checklist,
      checked: checked ?? this.checked,
      dateChecked: dateChecked,
    );
  }

  @override
  String toString() {
    return 'ChecklistModel{\n'
        ' checklist: $checklist,\n'
        ' checked: $checked,\n'
        ' dateChecked: $dateChecked,\n'
        '}';
  }
}
