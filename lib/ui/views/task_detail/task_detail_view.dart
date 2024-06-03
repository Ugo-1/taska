import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/ui/widgets/common/custom_icon_button/custom_icon_button.dart';
import 'package:taska/ui/widgets/common/sizes.dart';
import 'package:taska/utils/constants.dart';

import 'task_detail_viewmodel.dart';
import 'widgets/task_detail_content.dart';
import 'widgets/task_detail_header.dart';

class TaskDetailView extends StackedView<TaskDetailViewModel> {
  final int taskId;

  const TaskDetailView({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskDetailViewModel viewModel,
    Widget? child,
  ) {
    final TaskModel task = viewModel.task;
    final (Color?, Color?) taskColor = task.color.getColors(context);
    return Hero(
      tag: taskId,
      child: Scaffold(
        backgroundColor: taskColor.$1,
        appBar: AppBar(
          backgroundColor: taskColor.$1,
          leading: CustomIconButton.noBackground(
            onTap: viewModel.back,
            icon: const Icon(Icons.arrow_back_rounded),
            iconColor: taskColor.$2!,
            size: 24,
          ),
          systemOverlayStyle: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle
              ?.copyWith(
                statusBarBrightness:
                    context.isDarkMode() ? Brightness.dark : Brightness.light,
                statusBarIconBrightness:
                    context.isDarkMode() ? Brightness.dark : Brightness.light,
              ),
          actions: [
            if (viewModel.task.hasStarted)
              CustomIconButton.noBackground(
                onTap: viewModel.toInProgress,
                icon: const Icon(Icons.info_rounded),
                iconColor: taskColor.$2!,
                size: 24,
                tooltip: 'Task progress',
              ),
            CustomIconButton.noBackground(
              onTap: viewModel.editTask,
              icon: SvgPicture.asset(
                kiEditTask,
                colorFilter: ColorFilter.mode(taskColor.$2!, BlendMode.srcIn),
              ),
              size: 24,
              tooltip: 'Edit task',
            ),
          ],
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskName,
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: taskColor.$2,
                        ),
                      ),
                      const HSize(18),
                      TaskDetailHeader(
                        title: 'Start Date',
                        detail: task.startDate.formatDate(),
                        color: taskColor.$2,
                      ),
                      if (task.endDate != null)
                        TaskDetailHeader(
                          title: 'End Date',
                          detail: task.endDate!.formatDate(),
                          color: taskColor.$2,
                        ),
                      TaskDetailHeader(
                        title: 'Time',
                        detail:
                            '${task.startTime.toLocaleTime()} - ${task.endTime.toLocaleTime()}',
                        color: taskColor.$2,
                      ),
                      TaskDetailHeader(
                        title: 'Frequency',
                        detail: task.taskFrequency.getTaskFrequency(true),
                        color: taskColor.$2,
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: context.colors.background,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskDetailContent(
                        title: 'Description',
                        detail: task.description,
                        taskColor: taskColor.$1,
                      ),
                      TaskDetailContent(
                        title: 'Color',
                        detail: task.color.getColorName(),
                        taskColor: taskColor.$1,
                        trailing: CircleAvatar(
                          radius: 10,
                          backgroundColor: taskColor.$1,
                        ),
                      ),
                      if (task.checklist.isNotEmpty) ...[
                        Text(
                          'Checklist',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                        const HSize(6),
                        ...task.checklist.map(
                          (item) {
                            final bool isChecked = item.wasCheckedToday;
                            return GestureDetector(
                              onTap: () => viewModel.updateChecklist(item),
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: taskColor.$1,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    if (viewModel.task.isTodayCurrentTask) ...[
                                      AnimatedContainer(
                                        height: 20,
                                        width: 20,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: taskColor.$2!),
                                          color: isChecked
                                              ? taskColor.$2!
                                              : Colors.transparent,
                                        ),
                                        child: isChecked
                                            ? Icon(
                                                Icons.check_rounded,
                                                color: taskColor.$1!,
                                                size: 16,
                                              )
                                            : null,
                                      ),
                                      const WSize(10),
                                    ],
                                    Flexible(
                                      child: Text(
                                        item.checklist,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: isChecked
                                              ? taskColor.$2?.withOpacity(.6)
                                              : taskColor.$2,
                                          decoration: isChecked
                                              ? TextDecoration.lineThrough
                                              : null,
                                          decorationColor:
                                              taskColor.$2?.withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ).animate().slideY(
                      begin: 1,
                      end: 0,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TaskDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TaskDetailViewModel(taskId: taskId);
}
