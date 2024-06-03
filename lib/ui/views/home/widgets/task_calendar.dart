import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/extensions/context_extension.dart';
import 'package:taska/ui/views/home/home_viewmodel.dart';

class TaskCalendar extends ViewModelWidget<HomeViewModel> {
  /// If the table calendar should be open to calendar formats
  final bool isCompact;

  const TaskCalendar({
    super.key,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final DateTime firstDay =
        DateTime(viewModel.focusedDay.year, viewModel.focusedDay.month - 2);
    final DateTime lastDay =
        DateTime(viewModel.focusedDay.year, viewModel.focusedDay.month + 2);
    final CalendarFormat calendarFormat =
        isCompact ? viewModel.calendarFormat : CalendarFormat.month;
    final Map<CalendarFormat, String> availableFormats = isCompact
        ? const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          }
        : const {
            CalendarFormat.month: 'Month',
          };
    return TableCalendar(
      key: ValueKey(viewModel.focusedDay),
      focusedDay: viewModel.focusedDay,
      eventLoader: viewModel.getEvents,
      calendarFormat: calendarFormat,
      firstDay: firstDay,
      availableCalendarFormats: availableFormats,
      lastDay: lastDay,
      availableGestures: AvailableGestures.horizontalSwipe,
      onPageChanged: viewModel.onPageChanged,
      selectedDayPredicate: (day) => isSameDay(viewModel.selectedDay, day),
      onDaySelected: (day, focusedDay) =>
          viewModel.changeSelectedDay(day, focusedDay),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: false,
        cellMargin: EdgeInsets.all(10),
      ),
      daysOfWeekVisible: true,
      rowHeight: context.tsfScale(60, maxScaleFactor: 1.5, scaleFactor: 0.8),
      daysOfWeekHeight: context.tsfScale(20, maxScaleFactor: 1.5),
      onFormatChanged: viewModel.changeCalendarFormat,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: context.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: context.textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w400,
          color: context.colors.outline,
        ),
        weekendStyle: context.textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w400,
          color: context.colors.outline,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (_, date, markers) => _CalendarDateBuilder(
          date: date,
          events: markers.length,
        ),
        defaultBuilder: (_, date, __) => const SizedBox.shrink(),
        selectedBuilder: (_, date, __) => _CalendarDateBuilder(
          date: date,
        ),
        outsideBuilder: (_, date, __) => const SizedBox.shrink(),
      ),
    );
  }
}

class _CalendarDateBuilder extends ViewModelWidget<HomeViewModel> {
  final DateTime date;
  final int events;

  const _CalendarDateBuilder({
    required this.date,
    this.events = 0,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final bool isSelected = isSameDay(date, viewModel.selectedDay);
    final bool isToday = isSameDay(date, DateTime.now());
    final bool noEvents = events < 1;
    return AnimatedScale(
      scale: isSelected ? 1 : .85,
      duration: const Duration(milliseconds: 400),
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.all(4),
          height: context.tsfScale(60, maxScaleFactor: 1.5, scaleFactor: 0.8),
          width: 60,
          decoration: isSelected || isToday
              ? BoxDecoration(
                  color: isSelected ? context.colors.primaryContainer : null,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: context.colors.primary,
                  ),
                )
              : null,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Text(
                '${date.day}',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? context.colors.onPrimaryContainer
                      : context.colors.onBackground,
                ),
              ),
              if (!noEvents)
                Positioned(
                  bottom: 0,
                  right: 0,
                  height: context.tsfScale(20, maxScaleFactor: 1.5),
                  width: 20,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.colors.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$events',
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
