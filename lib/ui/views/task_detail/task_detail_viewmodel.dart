import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.router.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/services/task_service.dart';

class TaskDetailViewModel extends ReactiveViewModel {
  int taskId;
  final TaskService _taskService = locator<TaskService>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskService];

  TaskModel get task =>
      _taskService.tasks.value.firstWhere((element) => element.id == taskId);

  TaskDetailViewModel({
    required this.taskId,
  });

  void back() {
    _navigationService.back();
  }

  void editTask() async {
    final int? id = await _navigationService.navigateToEditTaskView(task: task);
    if (id != null){
      taskId = id;
      rebuildUi();
    }
  }

  void toInProgress(){
    _navigationService.navigateToInProgressView(id: taskId);
  }

  void updateChecklist(ChecklistModel item) {
    if (!task.isTodayTask) return;
    final int index = task.checklist.indexOf(item);
    ChecklistModel newChecklist;
    if (item.wasCheckedToday) {
      newChecklist = item.copyWith(
        checked: false,
        dateChecked: null,
      );
    } else {
      newChecklist = item.copyWith(
        checked: true,
        dateChecked: DateTime.now(),
      );
    }
    task.checklist[index] = newChecklist;
    final TaskModel newTask =
        task.copyWith(checklist: List.from(task.checklist));
    _taskService.updateTask(newTask, taskId);
  }
}
