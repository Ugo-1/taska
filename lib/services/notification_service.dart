import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.logger.dart';
import 'package:taska/app/app.router.dart';
import 'package:taska/models/task_notification_model.dart';
import 'package:taska/services/permission_service.dart';
import 'package:taska/services/task_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String _kChannelId = 'taska_id';
const String _kChannelName = 'Task Reminder';
const String _kChannelDescription =
    'Receive timely reminders to complete tasks';

class NotificationService {
  final _logger = getLogger('Notification Service');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> init() async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: const AndroidInitializationSettings("ic_notification"),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      ),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    _onNotificationIdReceived(id);
    return;
  }

  void _onDidReceiveNotificationResponse(NotificationResponse response) async {
    _logger.i('Notification with id ${response.id} is tapped');
    if (response.id != null) {
      _onNotificationIdReceived(response.id!);
    } else {
      _navigationService.navigateToHomeView();
    }
    return;
  }

  void _onNotificationIdReceived(int id) {
    final TaskService taskService = locator<TaskService>();
    taskService.clearOldTask();
    _navigationService.navigateToInProgressView(id: id);
  }

  /// To get the next instance of a weekday
  tz.TZDateTime _nextInstanceOfDayOfWeek(TimeOfDay time, int dayOfWeek) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    // Calculate the number of days to add to reach the desired weekday
    int daysToAdd = dayOfWeek - now.weekday;
    if (daysToAdd <= 0) {
      daysToAdd += 7; // Handle cases where desired day is already passed
    }
    scheduledDate = scheduledDate.add(Duration(days: daysToAdd));
    return scheduledDate;
  }

  /// To schedule a notification
  Future<void> _zonedSchedule(
    int id,
    TaskNotificationModel taskNotification,
    tz.TZDateTime scheduledDate, [
    DateTimeComponents? dateTimeComponents,
  ]) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      taskNotification.taskName,
      taskNotification.description,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _kChannelId,
          _kChannelName,
          channelDescription: _kChannelDescription,
          priority: Priority.high,
          importance: Importance.high,
          fullScreenIntent: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> show(TaskNotificationModel taskNotification) async {
    final PermissionService permissionService = locator<PermissionService>();
    final requestPermission =
        await permissionService.requestNotificationPermission();
    if (!requestPermission) return;
    // Notification is shown if the task frequency does not contain the week day
    // and the start date time is after the current date
    if (!taskNotification.taskFrequency
            .contains(taskNotification.startDate.weekday) &&
        taskNotification.startDateTime.isAfter(DateTime.now())) {
      await _zonedSchedule(
        taskNotification.id,
        taskNotification,
        tz.TZDateTime.from(taskNotification.startDateTime, tz.local),
      );
    }
    if (taskNotification.taskFrequency.isNotEmpty) {
      // For repeated notifications
      for (int weekday in taskNotification.taskFrequency) {
        final int index = taskNotification.taskFrequency.indexOf(weekday);
        await _zonedSchedule(
          taskNotification.taskFrequencyId[index],
          taskNotification,
          _nextInstanceOfDayOfWeek(taskNotification.startTime, weekday),
          DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
    return;
  }

  Future<void> cancelNotification(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }
}
