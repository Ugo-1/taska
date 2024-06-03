// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/primary_modal/primary_modal_sheet.dart';
import '../ui/bottom_sheets/task_creation_failed/task_creation_failed_sheet.dart';

enum BottomSheetType {
  taskCreationFailed,
  primaryModal,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.taskCreationFailed: (context, request, completer) =>
        TaskCreationFailedSheet(request: request, completer: completer),
    BottomSheetType.primaryModal: (context, request, completer) =>
        PrimaryModalSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
