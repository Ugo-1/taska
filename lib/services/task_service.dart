import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.logger.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/models/task_notification_model.dart';
import 'package:taska/services/notification_service.dart';
import 'package:taska/services/preference_storage_service.dart';

const String _taskKey = 'task_service_key';

class TaskService with ListenableServiceMixin {
  final PreferenceStorageService _storageService =
      locator<PreferenceStorageService>();
  final ValueNotifier<List<TaskModel>> tasks = ValueNotifier([]);
  final NotificationService _notificationService =
      locator<NotificationService>();
  final _logger = getLogger('Task Service');

  ValueListenable get _tasksListenable =>
      _storageService.listenable([_taskKey]);

  TaskService() {
    init();
    listenToReactiveValues([tasks]);
  }

  void init() {
    _setNotifier();
    clearOldTask();
    _tasksListenable.addListener(_setNotifier);
  }

  List<TaskModel> listener() {
    List<dynamic>? tasks = _storageService.read(_taskKey);
    tasks ??= [];
    return tasks.map((e) => TaskModel.fromJson(e)).toList();
  }

  void _setNotifier() {
    tasks.value = listener();
  }

  Future<void> createTask(TaskModel task) async {
    await _notificationService.show(TaskNotificationModel.fromTaskModel(task));
    final List<TaskModel> updatedTask = tasks.value..add(task);
    return await _writeTask(updatedTask);
  }

  Future<void> editTask(TaskModel task, TaskModel oldTask) async {
    if (task == oldTask) return;
    // Cancel old notifications
    await _notificationService.cancelNotification(oldTask.id);
    for (int id in oldTask.taskFrequencyId) {
      await _notificationService.cancelNotification(id);
    }
    // Remove old task
    final int index = tasks.value.indexWhere((element) => element.id == oldTask.id);
    tasks.value[index] = task;
    // Show new notification
    await _notificationService.show(TaskNotificationModel.fromTaskModel(task));
    return await _writeTask(List.from(tasks.value));
  }

  Future<void> updateTask(TaskModel task, int id) async {
    final int index = tasks.value.indexWhere((element) => element.id == id);
    tasks.value[index] = task;
    return await _writeTask(List.from(tasks.value));
  }

  Future<void> deleteTask(int id) async {
    await _notificationService.cancelNotification(id);
    final List<TaskModel> updatedTask = tasks.value
      ..removeWhere((element) => element.id == id);
    return await _writeTask(updatedTask);
  }
  
  Future<void> clearOldTask() async {
    final List<TaskModel> updatedTask = List.from(tasks.value);
    _logger.i('Before clearing - ${updatedTask.length}');
    final DateTime now = DateTime.now();
    for (TaskModel task in updatedTask){
      final DateTime? endDate = task.endDate?.copyWith(
          hour: task.endTime.hour, minute: task.endTime.minute);
      if (endDate != null && now.isAfter(endDate)){
        await _notificationService.cancelNotification(task.id);
        for (int id in task.taskFrequencyId){
          await _notificationService.cancelNotification(id);
        }
        updatedTask.remove(task);
      }
    }
    _logger.i('After clearing - ${updatedTask.length}');
    return await _writeTask(updatedTask);
  }

  Future<void> _writeTask(List<TaskModel> updatedTask) async {
    return await _storageService.write(
        _taskKey, updatedTask.map((e) => e.toJson()).toList());
  }
}
