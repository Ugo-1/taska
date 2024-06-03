import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';
import 'package:taska/ui/widgets/common/custom_icon_button/custom_icon_button.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

class TaskCard extends ViewModelWidget<HomeViewModel> {
  final int index;

  const TaskCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final TaskModel task = viewModel.tasksList.elementAt(index);
    final (Color?, Color?) taskColors = task.color.getColors(context);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: viewModel.taskType.isCurrent() ? 1 : 0.6,
      child: Slidable(
        key: ValueKey(task),
        endActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => viewModel.deleteTask(task.id),
              backgroundColor: context.colors.error,
              foregroundColor: context.colors.onError,
              icon: Icons.delete_outline_rounded,
            ),
          ],
        ),
        child: MediaQuery.withClampedTextScaling(
          maxScaleFactor: 1.5,
          child: DefaultTextStyle.merge(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: SizedBox(
              height: context.tsfScale(120, scaleFactor: 0.9, maxScaleFactor: 1.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Time
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            task.startTime.toLocaleTime(),
                            style: context.textTheme.labelMedium,
                          ),
                          const HSize(10),
                          Flexible(
                            child: VerticalDivider(
                              color: context.colors.onBackground,
                            ),
                          ),
                          const HSize(10),
                          Text(
                            task.endTime.toLocaleTime(),
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    const WSize(15),

                    // Task Card
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: taskColors.$1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.taskName,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: taskColors.$2,
                              ),
                            ),
                            const HSize(5),
                            Text(
                              task.description,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: taskColors.$2,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (task.hasStarted)
                                Expanded(
                                  flex: 3,
                                  child: Builder(
                                    builder: (context) {
                                      final double progress = task.getTaskProgress();
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'In progress - ${progress.toPercent()}',
                                            style: context.textTheme.labelSmall?.copyWith(
                                              color: taskColors.$2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const HSize(4),
                                          LinearProgressIndicator(
                                            value: progress,
                                            valueColor: AlwaysStoppedAnimation(context.colors.onBackground),
                                            backgroundColor: context.colors.background,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ],
                                      );
                                    }
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Hero(
                                      tag: task.id,
                                      child: CustomIconButton(
                                        tooltip: 'To task details',
                                        icon: const Icon(Icons.arrow_upward_rounded),
                                        onTap: () => viewModel.toTaskDetails(task.id),
                                        backgroundColor: context.colors.background,
                                        iconColor: context.colors.onBackground,
                                        size: 30,
                                        iconSize: 20,
                                      ).animate().rotate(
                                        begin: 0,
                                        end: 20.convertToRotateRadians(),
                                        delay: Duration(milliseconds: (400 * index) + 900),
                                        duration: const Duration(milliseconds: 500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ).animate().slideX(
            begin: 1,
            end: 0,
            delay: Duration(milliseconds: 50 * index),
            duration: const Duration(milliseconds: 400),
          ),
    );
  }
}
