import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.bottomsheets.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.logger.dart';
import 'package:taska/enums/colors_enum.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/mixins/create_task_mixin.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/services/task_service.dart';
import 'package:taska/ui/views/edit_task/edit_task_view.form.dart';
import 'package:taska/utils/constants.dart';

class EditTaskViewModel extends FormViewModel with $EditTaskView, CreateTaskMixin {
  final TaskModel oldTask;
  DateTime today = DateTime.now();
  DateTime startDate;
  DateTime? endDate;
  TimeOfDay startTime, endTime;
  List<int> taskFrequency = [];
  ColorsEnum taskColor;
  List<String> taskCheckList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TaskService _taskService = locator<TaskService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final _logger = getLogger('Edit Task');

  EditTaskViewModel({
    required this.oldTask,
  })  : startDate = oldTask.startDate,
        endDate = oldTask.endDate,
        startTime = oldTask.startTime,
        endTime = oldTask.endTime,
        taskFrequency = List.from(oldTask.taskFrequency),
        taskColor = oldTask.color,
        taskCheckList = List.from(oldTask.checklist)..add('') {
    _initControllers();
  }

  void _initControllers() {
    taskNameController.text = oldTask.taskName;
    startDateController.text = startDate.formatDate(kdfTaskDate);
    startTimeController.text = startTime.toLocaleTime();
    endDateController.text = endDate?.formatDate(kdfTaskDate) ?? '';
    endTimeController.text = endTime.toLocaleTime();
    descriptionController.text = oldTask.description;
    rebuildUi();
  }

  void changeStartDate(DateTime date) {
    startDate = date;
    startDateController.text = date.formatDate(kdfTaskDate);
    rebuildUi();
  }

  void changeStartTime(TimeOfDay time) {
    startTime = time;
    startTimeController.text = time.toLocaleTime();
    rebuildUi();
  }

  void changeEndDate(DateTime date) {
    endDate = date;
    endDateController.text = date.formatDate(kdfTaskDate);
    rebuildUi();
  }

  void changeEndTime(TimeOfDay time) {
    endTime = time;
    endTimeController.text = time.toLocaleTime();
    rebuildUi();
  }

  void updateFrequency(int day) {
    if (taskFrequency.contains(day)) {
      taskFrequency.remove(day);
    } else {
      taskFrequency.add(day);
    }
    taskFrequency.sort();
    rebuildUi();
  }

  void updateColor(ColorsEnum color) {
    taskColor = color;
    rebuildUi();
  }

  void reorderChecklist(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = taskCheckList.removeAt(oldIndex);
    taskCheckList.insert(newIndex, items);
    rebuildUi();
  }

  void updateChecklistText(int index, String text) {
    taskCheckList[index] = text;
  }

  void removeChecklistItem(int index) {
    if (taskCheckList.length == 1) return;
    taskCheckList.removeAt(index);
    rebuildUi();
  }

  void addChecklistItem(int index) {
    taskCheckList.insert(index + 1, '');
    rebuildUi();
  }

  void updateTask() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final (bool, TaskModel?) canCreateTask = isTaskOverlapping(
        startDate: startDate,
        startTime: startTime,
        endTime: endTime,
        taskFrequency: taskFrequency,
        taskId: oldTask.id,
      );
      if (canCreateTask.$1) {
        taskCheckList.removeWhere((e) => e.isEmpty);
        final List<ChecklistModel> checklist =
            taskCheckList.map((e) => ChecklistModel(checklist: e)).toList();
        final DateTime startDateTime = startDate.copyWith(
          hour: startTime.hour,
          minute: startTime.minute,
        );
        final TaskModel newTask = TaskModel(
          id: ValueKey(startDateTime).hashCode,
          taskName: taskNameController.text.trim(),
          description: descriptionController.text.trim(),
          startDate: startDate,
          startTime: startTime,
          endTime: endTime,
          color: taskColor,
          taskFrequency: taskFrequency,
          taskFrequencyId: taskFrequency
              .map((e) => ValueKey(e.nextInstanceOfDayOfWeek()).hashCode)
              .toList(),
          endDate: endDate,
          checklist: checklist,
        );
        _logger.i(newTask);
        await _taskService.editTask(newTask, oldTask);
        _navigationService.back(result: newTask.id);
      } else {
        _logger.i(canCreateTask.$2);
        final TaskModel task = canCreateTask.$2!;
        _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.taskCreationFailed,
          data: task,
          ignoreSafeArea: false,
        );
      }
    }
  }
}
