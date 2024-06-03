import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';

class HomeFAB extends ViewModelWidget<HomeViewModel> {
  const HomeFAB({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FloatingActionButton(
      onPressed: viewModel.createTask,
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      tooltip: 'Create a new task',
      child: const Icon(Icons.add_rounded),
    );
  }
}
