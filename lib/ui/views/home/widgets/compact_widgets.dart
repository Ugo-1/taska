import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/utils/theme.dart';
import '../home_viewmodel.dart';
import 'home_app_bar.dart';
import 'task_calendar.dart';

/// The app bar for the compact view
class CompactAppBar extends ViewModelWidget<HomeViewModel> {
  const CompactAppBar({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SliverAppBar(
      expandedHeight:
          context.tsfScaleNull(viewModel.expandedHeight, maxScaleFactor: 1.5),
      stretch: true,
      automaticallyImplyLeading: false,
      flexibleSpace: viewModel.isExpanded
          ? const FlexibleSpaceBar(
              background: _FlexibleBackground(),
            )
          : null,
      title: viewModel.isExpanded ? null : const HomeAppBarTitle(),
      centerTitle: false,
      onStretchTrigger: () =>
          viewModel.onStretchTrigger(context.heightPercent(35)),
      actions: viewModel.isExpanded
          ? null
          : const [
              CalendarIcon(
                isCompact: true,
              ),
            ],
      pinned: true,
    );
  }
}

class _FlexibleBackground extends ViewModelWidget<HomeViewModel> {
  const _FlexibleBackground();

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Taska',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: kFConstantia,
              ),
            ),
            Text(
              viewModel.taskType.getTaskMessage(viewModel.tasksList.length),
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.colors.onSurfaceVariant,
                fontFamily: kFConstantia,
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomRight,
              child: CalendarIcon(isCompact: true),
            ),
          ],
        ),
      ),
    );
  }
}

/// The calendar for the compact view
class CompactCalendar extends ViewModelWidget<HomeViewModel> {
  const CompactCalendar({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return (viewModel.calendarFormat == CalendarFormat.week)
        ? const SliverToBoxAdapter(
            child: _Calendar(),
          )
        : const SliverPinnedHeader(
            child: _Calendar(),
          );
  }
}

class _Calendar extends ViewModelWidget<HomeViewModel> {
  const _Calendar();

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.colors.outlineVariant),
          ),
        ),
        child: const TaskCalendar(
          isCompact: true,
        ).animate().fadeIn(
              begin: .6,
              duration: const Duration(milliseconds: 600),
            ),
      ),
    );
  }
}
