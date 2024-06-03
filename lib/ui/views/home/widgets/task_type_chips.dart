import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';

class TaskTypeChips extends ViewModelWidget<HomeViewModel> {
  final bool isCompact;

  const TaskTypeChips({
    super.key,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SliverPinnedHeader(
      child: Container(
        color: context.colors.background.withOpacity(0.9),
        padding: isCompact
            ? const EdgeInsets.fromLTRB(20, 10, 20, 0)
            : const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Wrap(
          spacing: 10,
          children: TaskType.values.map((type) {
            final bool isSelected = viewModel.taskType == type;
            return ActionChip(
              backgroundColor: isSelected
                  ? context.colors.primary
                  : context.colors.background,
              avatar: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: context.colors.onPrimary,
                    )
                  : null,
              label: Text(type.name),
              labelStyle: context.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? context.colors.onPrimary
                    : context.colors.onBackground,
              ),
              onPressed: () => viewModel.changeTaskType(type),
            );
          }).toList(),
        ),
      ),
    );
  }
}
