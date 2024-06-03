import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

class EmptyTask extends ViewModelWidget<HomeViewModel> {
  const EmptyTask({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.primaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  viewModel.taskType.isCurrent()
                      ? Icons.note_add_rounded
                      : Icons.note_rounded,
                  size: 40,
                  color: context.colors.onPrimaryContainer,
                ),
              ),
            ),
            const HSize(30),
            Text(
              viewModel.taskType.getEmptyTitle(),
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            const HSize(10),
            Text(
              viewModel.taskType.getEmptyContent(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
