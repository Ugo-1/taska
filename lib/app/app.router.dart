// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i7;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;
import 'package:taska/models/task_model.dart' as _i8;
import 'package:taska/ui/views/create_task/create_task_view.dart' as _i3;
import 'package:taska/ui/views/edit_task/edit_task_view.dart' as _i5;
import 'package:taska/ui/views/home/home_view.dart' as _i2;
import 'package:taska/ui/views/in_progress/in_progress_view.dart' as _i6;
import 'package:taska/ui/views/task_detail/task_detail_view.dart' as _i4;

class Routes {
  static const homeView = '/home-view';

  static const createTaskView = '/create-task-view';

  static const taskDetailView = '/task-detail-view';

  static const editTaskView = '/edit-task-view';

  static const inProgressView = '/in-progress-view';

  static const all = <String>{
    homeView,
    createTaskView,
    taskDetailView,
    editTaskView,
    inProgressView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.createTaskView,
      page: _i3.CreateTaskView,
    ),
    _i1.RouteDef(
      Routes.taskDetailView,
      page: _i4.TaskDetailView,
    ),
    _i1.RouteDef(
      Routes.editTaskView,
      page: _i5.EditTaskView,
    ),
    _i1.RouteDef(
      Routes.inProgressView,
      page: _i6.InProgressView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.CreateTaskView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.CreateTaskView(),
        settings: data,
      );
    },
    _i4.TaskDetailView: (data) {
      final args = data.getArgs<TaskDetailViewArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.TaskDetailView(key: args.key, taskId: args.taskId),
        settings: data,
      );
    },
    _i5.EditTaskView: (data) {
      final args = data.getArgs<EditTaskViewArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.EditTaskView(key: args.key, task: args.task),
        settings: data,
      );
    },
    _i6.InProgressView: (data) {
      final args = data.getArgs<InProgressViewArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.InProgressView(key: args.key, id: args.id),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TaskDetailViewArguments {
  const TaskDetailViewArguments({
    this.key,
    required this.taskId,
  });

  final _i7.Key? key;

  final int taskId;

  @override
  String toString() {
    return '{"key": "$key", "taskId": "$taskId"}';
  }

  @override
  bool operator ==(covariant TaskDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.taskId == taskId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ taskId.hashCode;
  }
}

class EditTaskViewArguments {
  const EditTaskViewArguments({
    this.key,
    required this.task,
  });

  final _i7.Key? key;

  final _i8.TaskModel task;

  @override
  String toString() {
    return '{"key": "$key", "task": "$task"}';
  }

  @override
  bool operator ==(covariant EditTaskViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.task == task;
  }

  @override
  int get hashCode {
    return key.hashCode ^ task.hashCode;
  }
}

class InProgressViewArguments {
  const InProgressViewArguments({
    this.key,
    required this.id,
  });

  final _i7.Key? key;

  final int id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant InProgressViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateTaskView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createTaskView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTaskDetailView({
    _i7.Key? key,
    required int taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.taskDetailView,
        arguments: TaskDetailViewArguments(key: key, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditTaskView({
    _i7.Key? key,
    required _i8.TaskModel task,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editTaskView,
        arguments: EditTaskViewArguments(key: key, task: task),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInProgressView({
    _i7.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.inProgressView,
        arguments: InProgressViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateTaskView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createTaskView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTaskDetailView({
    _i7.Key? key,
    required int taskId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.taskDetailView,
        arguments: TaskDetailViewArguments(key: key, taskId: taskId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditTaskView({
    _i7.Key? key,
    required _i8.TaskModel task,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editTaskView,
        arguments: EditTaskViewArguments(key: key, task: task),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInProgressView({
    _i7.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.inProgressView,
        arguments: InProgressViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
