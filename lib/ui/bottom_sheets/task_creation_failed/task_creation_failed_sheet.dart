import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/ui/widgets/common/primary_button/primary_button.dart';
import 'package:taska/ui/widgets/common/sizes.dart';
import 'package:taska/utils/theme.dart';

import 'task_creation_failed_sheet_model.dart';

class TaskCreationFailedSheet
    extends StackedView<TaskCreationFailedSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const TaskCreationFailedSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskCreationFailedSheetModel viewModel,
    Widget? child,
  ) {
    assert(request.data is TaskModel);
    final TaskModel task = request.data;
    return Container(
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints(
        maxHeight: context.heightPercent(50),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.errorContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.warning_rounded,
                  size: 30,
                  color: context.colors.onErrorContainer,
                ),
              ),
            ),
            const HSize(20),
            Text(
              'Task Creation Failed',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: kFConstantia,
                fontWeight: FontWeight.w500,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const HSize(10),
            Text.rich(
              TextSpan(
                text: 'This task overlaps with an existing task ',
                children: [
                  TextSpan(
                    text: task.taskName,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.outline,
                    ),
                  ),
                  const TextSpan(
                    text: ' scheduled for ',
                  ),
                  TextSpan(
                    text:
                        '${task.startTime.toLocaleTime()} to ${task.endTime.toLocaleTime()}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.outline,
                    ),
                  ),
                  if (task.taskFrequency.isEmpty)...[
                    const TextSpan(
                      text: ', on ',
                    ),
                    TextSpan(
                      text:
                      '${task.startDate.formatDate('yMMMMEEEEd')}.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                  ],
                  if (task.taskFrequency.isNotEmpty) ...[
                    const TextSpan(
                      text: ', which repeats ',
                    ),
                    TextSpan(
                      text:
                      task.taskFrequency.getTaskFrequency(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                    const TextSpan(
                      text: ' from ',
                    ),
                    TextSpan(
                      text: task.startDate.formatDate(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                    if (task.endDate != null)
                      TextSpan(
                        text: 'to ${task.endDate!.formatDate()}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.outline,
                        ),
                      ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ],
              ),
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colors.outline,
              ),
              softWrap: true,
            ),
            PrimaryButton(
              width: double.maxFinite,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              onTap: () => completer?.call(SheetResponse(confirmed: true)),
              buttonText: 'Close',
            ),
          ],
        ),
      ),
    );
  }

  @override
  TaskCreationFailedSheetModel viewModelBuilder(BuildContext context) =>
      TaskCreationFailedSheetModel();
}
