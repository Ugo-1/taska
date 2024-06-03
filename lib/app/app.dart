import 'package:taska/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/services/preference_storage_service.dart';
import 'package:taska/ui/views/create_task/create_task_view.dart';
import 'package:taska/services/task_service.dart';
import 'package:taska/ui/bottom_sheets/task_creation_failed/task_creation_failed_sheet.dart';
import 'package:taska/ui/views/task_detail/task_detail_view.dart';
import 'package:taska/ui/views/edit_task/edit_task_view.dart';
import 'package:taska/services/notification_service.dart';
import 'package:taska/ui/views/in_progress/in_progress_view.dart';
import 'package:taska/services/permission_service.dart';
import 'package:taska/ui/bottom_sheets/primary_modal/primary_modal_sheet.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CreateTaskView),
    MaterialRoute(page: TaskDetailView),
    MaterialRoute(page: EditTaskView),
    MaterialRoute(page: InProgressView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    InitializableSingleton(classType: PreferenceStorageService),
    InitializableSingleton(classType: NotificationService),
    LazySingleton(classType: PermissionService),
    LazySingleton(classType: TaskService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: TaskCreationFailedSheet),
    StackedBottomsheet(classType: PrimaryModalSheet),
// @stacked-bottom-sheet
  ],
  logger: StackedLogger(),
)
class App {}
