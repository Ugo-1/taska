import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/app/app.locator.dart';
import 'package:taska/app/app.logger.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/services/task_service.dart';

const double smallScale = 0.85;
const double normalScale = 1;

class InProgressViewModel extends BaseViewModel {
  final int id;
  final TaskService _taskService = locator<TaskService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _logger = getLogger('In progress');
  final Duration duration = const Duration(milliseconds: 500);

  TaskModel get task => _taskService.tasks.value
      .firstWhere((element) => element.ids.contains(id));
  Timer? _rebuildTimer;
  double scale = normalScale;
  Timer? _endOfTaskTimer;
  Timer? _scaleTimer;

  InProgressViewModel({required this.id}) {
    _init();
  }

  void _init() {
    final Duration taskDuration = task.endTime.toDateTime().difference(DateTime.now());
    if (taskDuration.isNegative){
      _navigationService.back();
    }
    _scaleTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _logger.d('Scaling in progress');
      _scaling();
    });
    _logger.i('Task duration is $taskDuration');
    if (!task.hasStarted && taskDuration.isNegative) return;
    _rebuildTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      rebuildUi();
    });
    _endOfTaskTimer = Timer(taskDuration, () {
      _logger.i('Duration done');
      _navigationService.back();
    });
  }

  void _scaling() async {
    _changeScale();
    rebuildUi();
    await Future.delayed(duration);
    _changeScale();
    rebuildUi();
  }

  void _changeScale(){
    if (scale == normalScale){
      scale = smallScale;
    } else {
      scale = normalScale;
    }
    rebuildUi();
  }

  void back(){
    _navigationService.back();
  }

  @override
  void dispose() {
    _scaleTimer?.cancel();
    _rebuildTimer?.cancel();
    _endOfTaskTimer?.cancel();
    super.dispose();
  }
}
