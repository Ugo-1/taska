import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/mixins/date_time_picker_mixin.dart';
import 'package:taska/ui/widgets/common/create_task/task_form_field.dart';
import 'package:taska/ui/widgets/common/sizes.dart';
import 'package:taska/utils/constants.dart';

class CreateTaskDateTime extends StatelessWidget with DateTimePickerMixin {
  final String dateTitle;
  final TextEditingController dateTextController;
  final ValueChanged<DateTime> onDateChanged;
  final DateTime? selectedDate;
  final String? Function(String?) dateValidator;
  final String timeTitle;
  final TextEditingController timeTextController;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimeOfDay? selectedTime;
  final String? Function(String?) timeValidator;
  final bool showDate;

  const CreateTaskDateTime({
    super.key,
    required this.dateTitle,
    required this.dateTextController,
    required this.onDateChanged,
    required this.selectedDate,
    required this.dateValidator,
    required this.timeTitle,
    required this.timeTextController,
    required this.onTimeChanged,
    required this.selectedTime,
    required this.timeValidator,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDate)...[
          Expanded(
            flex: 3,
            child: TaskFormField(
              excludeFieldFocus: true,
              enableInteractiveSelection: false,
              fieldTitle: dateTitle,
              fieldHint: today.formatDate(kdfTaskDate),
              textEditingController: dateTextController,
              validator: dateValidator,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showAdaptiveDatePicker(
                  context: context,
                  firstDate: today,
                  lastDate: today.addYears(50),
                  initialDate: selectedDate ?? today,
                  onDateChanged: onDateChanged,
                );
              },
              suffixIcon: const Icon(
                Icons.calendar_today_rounded,
                size: 16,
              ),
            ),
          ),
          const WSize(20),
        ],
        Expanded(
          flex: 2,
          child: TaskFormField(
            excludeFieldFocus: true,
            enableInteractiveSelection: false,
            fieldTitle: timeTitle,
            fieldHint: today.formatDate(kdfTaskTime),
            textEditingController: timeTextController,
            validator: timeValidator,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              showAdaptiveTimePicker(
                context: context,
                initialTime: selectedTime ?? today.toTimeOfDay(),
                onTimeChanged: onTimeChanged,
              );
            },
            suffixIcon: const Icon(
              Icons.access_time_filled_rounded,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
