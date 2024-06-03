import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

import 'widgets/compact_widgets.dart';
import 'widgets/empty_task.dart';
import 'widgets/home_fab.dart';
import 'widgets/task_card.dart';
import 'widgets/task_type_chips.dart';

class HomeCompactView extends ViewModelWidget<HomeViewModel> {
  const HomeCompactView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: viewModel.scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            const CompactAppBar(),
            if (viewModel.showCalendar) const CompactCalendar(),
            if (viewModel.isToday) const TaskTypeChips(isCompact: true,),
            (viewModel.tasksList.isEmpty)
                ? const EmptyTask()
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    sliver: SliverList.separated(
                      itemCount: viewModel.tasksList.length,
                      separatorBuilder: (_, __) => const HSize(20),
                      itemBuilder: (_, index) => TaskCard(index: index),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: const HomeFAB(),
    );
  }
}
