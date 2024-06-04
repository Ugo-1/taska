import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.router.dart';
import 'package:taska/extensions/list_extension.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/services/task_service.dart';

enum TaskType {
  upcoming('Upcoming'),
  completed('Completed');

  final String name;

  const TaskType(this.name);
}

class HomeViewModel extends ReactiveViewModel {
  double? expandedHeight;
  bool showCalendar = true;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  TaskType taskType = TaskType.upcoming;
  Timer? _timer;

  final DateTime _today = DateTime.now();
  final ScrollController scrollController = ScrollController();
  final NavigationService _navigationService = locator<NavigationService>();
  final TaskService _taskService = locator<TaskService>();

  bool get isExpanded => expandedHeight != null;
  bool get isToday => isSameDay(_today, selectedDay);

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskService];
  List<TaskModel> get dateTasks =>
      _taskService.tasks.value.getTasksForDay(selectedDay);
  List<TaskModel> get tasksCurrent =>
      dateTasks.getDayCurrentTasks(selectedDay);
  List<TaskModel> get tasksPast => dateTasks.getDayPastTasks(selectedDay, tasksCurrent);

  List<TaskModel> get tasksList => taskType == TaskType.upcoming
      ? tasksCurrent
      : tasksPast;

  HomeViewModel() {
    _init();
  }

  void _init() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_){
      rebuildUi();
    });
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    final double offset = scrollController.offset;
    final ScrollDirection scrollDirection =
        scrollController.position.userScrollDirection;
    if (showCalendar) {
      if (calendarFormat == CalendarFormat.month) {
        _handleMonthFormatScroll(offset, scrollDirection);
      } else {
        _handleWeekFormatScroll(offset, scrollDirection);
      }
    }
    if (offset > 100) {
      if (expandedHeight != null) {
        scrollController.jumpTo(0);
        _changeExpandedHeight(null);
      }
    }
  }

  /// This handles the scroll when the calendar is in the week format
  void _handleWeekFormatScroll(double offset, ScrollDirection direction) {
    if (offset <= -50 && direction == ScrollDirection.forward) {
      changeCalendarFormat(CalendarFormat.month);
    }
  }

  /// This handles the scroll when the calendar is in the month format
  void _handleMonthFormatScroll(double offset, ScrollDirection direction) {
    if (offset >= 20 && direction == ScrollDirection.reverse) {
      changeCalendarFormat(CalendarFormat.week);
    }
  }

  void _changeExpandedHeight(double? height) {
    expandedHeight = height;
    rebuildUi();
  }

  Future<void> onStretchTrigger(double height) async {
    if (expandedHeight != null) return;
    await Future.delayed(Duration.zero, () => _changeExpandedHeight(height));
    return;
  }

  void changeTaskType(TaskType type) {
    if (type == taskType) return;
    taskType = type;
    rebuildUi();
  }

  void toggleShowCalendar() {
    showCalendar = !showCalendar;
    if (showCalendar) {
      final today = DateTime.now();
      selectedDay = today;
      focusedDay = today;
    }
    rebuildUi();
  }

  void toTaskDetails(int id) async {
    await _navigationService.navigateToTaskDetailView(taskId: id);
    rebuildUi();
  }

  void deleteTask(int id) async {
    await _taskService.deleteTask(id);
  }

  void createTask() {
    _navigationService.navigateToCreateTaskView();
  }

  void changeCalendarFormat(CalendarFormat format) {
    calendarFormat = format;
    rebuildUi();
  }

  void changeSelectedDay(DateTime day, DateTime focused) {
    selectedDay = day;
    focusedDay = focused;
    if (isSameDay(selectedDay, _today) || selectedDay.isAfter(_today)){
      changeTaskType(TaskType.upcoming);
    } else {
      changeTaskType(TaskType.completed);
    }
    rebuildUi();
  }

  void onPageChanged(DateTime day) {
    focusedDay = day;
    rebuildUi();
  }

  List<TaskModel> getEvents(DateTime day) {
    return _taskService.tasks.value.getTasksForDay(day);
  }

  @override
  void dispose() {
    _timer?.cancel();
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
