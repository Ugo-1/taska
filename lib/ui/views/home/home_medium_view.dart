import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/context_extension.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';
import 'package:taska/ui/views/home/widgets/home_app_bar.dart';
import 'package:taska/ui/views/home/widgets/home_fab.dart';
import 'package:taska/ui/views/home/widgets/task_calendar.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

import 'widgets/empty_task.dart';
import 'widgets/task_card.dart';
import 'widgets/task_type_chips.dart';

class HomeMediumView extends ViewModelWidget<HomeViewModel> {
  const HomeMediumView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const HomeAppBarTitle(),
        centerTitle: false,
        actions: const [
          CalendarIcon(
            isCompact: false,
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: SizedBox(
                width: context.widthPercent(45),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: MediaQuery.withClampedTextScaling(
                    maxScaleFactor: 1.5,
                    child: const TaskCalendar(
                      isCompact: false,
                    ),
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (viewModel.isToday) const TaskTypeChips(isCompact: false,),
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
          ],
        ),
      ),
      floatingActionButton: const HomeFAB(),
    );
  }
}
