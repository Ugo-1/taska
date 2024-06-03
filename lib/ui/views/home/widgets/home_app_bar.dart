import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';
import 'package:taska/ui/widgets/common/custom_text_button/custom_text_button.dart';

class HomeAppBarTitle extends ViewModelWidget<HomeViewModel> {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Builder(
      builder: (context) {
        final bool isTaskEmpty = viewModel.tasksList.isEmpty;
        final String taskCount =
            isTaskEmpty ? '' : ' (${viewModel.tasksList.length})';
        return Text('Taska$taskCount');
      },
    );
  }
}

class CalendarIcon extends ViewModelWidget<HomeViewModel> {
  final bool isCompact;

  const CalendarIcon({
    super.key,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final bool showCalendar = isCompact ? viewModel.showCalendar : true;
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: CustomTextButton(
        tooltip: showCalendar ? 'Hide calendar' : 'Show calendar',
        margin: const EdgeInsets.only(right: 20),
        backgroundColor: showCalendar ? context.colors.primary : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: context.colors.primary),
        ),
        onTap: isCompact ? viewModel.toggleShowCalendar : null,
        minimumSize: const Size.square(24),
        text: '${viewModel.selectedDay.day}',
        textStyle: context.textTheme.bodyMedium?.copyWith(
          color: showCalendar
              ? context.colors.onPrimary
              : context.colors.onBackground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
