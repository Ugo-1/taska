import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/models/task_model.dart';
import 'package:taska/ui/views/edit_task/edit_task_view.form.dart';
import 'package:taska/ui/widgets/common/create_task/create_task_color.dart';
import 'package:taska/ui/widgets/common/create_task/create_task_date_time.dart';
import 'package:taska/ui/widgets/common/create_task/create_task_frequency.dart';
import 'package:taska/ui/widgets/common/create_task/task_form_field.dart';
import 'package:taska/ui/widgets/common/custom_icon_button/custom_icon_button.dart';
import 'package:taska/ui/widgets/common/primary_button/primary_button.dart';
import 'package:taska/utils/validator_utils.dart';

import 'edit_task_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'taskName'),
  FormTextField(name: 'startDate'),
  FormTextField(name: 'startTime'),
  FormTextField(name: 'endDate'),
  FormTextField(name: 'endTime'),
  FormTextField(name: 'description'),
])
class EditTaskView extends StackedView<EditTaskViewModel> with $EditTaskView {
  final TaskModel task;

  const EditTaskView({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: Form(
                        key: viewModel.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Task name
                            TaskFormField(
                              fieldTitle: 'Task Name',
                              fieldHint: 'Grocery shopping',
                              textEditingController: taskNameController,
                              validator: ValidatorUtils.validateEmpty,
                            ),
                            // Start date time
                            CreateTaskDateTime(
                              dateTitle: 'Start Date',
                              dateTextController: startDateController,
                              onDateChanged: viewModel.changeStartDate,
                              selectedDate: viewModel.startDate,
                              dateValidator: ValidatorUtils.validateEmpty,
                              timeTitle: 'Start Time',
                              timeTextController: startTimeController,
                              onTimeChanged: viewModel.changeStartTime,
                              selectedTime: viewModel.startTime,
                              timeValidator: ValidatorUtils.validateEmpty,
                            ),
                            // End date time
                            CreateTaskDateTime(
                              dateTitle: 'End Date',
                              dateTextController: endDateController,
                              selectedDate: viewModel.endDate,
                              onDateChanged: viewModel.changeEndDate,
                              showDate: viewModel.taskFrequency.isNotEmpty,
                              dateValidator: (value) =>
                                  ValidatorUtils.validateEndDate(
                                viewModel.startDate,
                                viewModel.startTime,
                                viewModel.endDate,
                                viewModel.endTime,
                              ),
                              timeTitle: 'End Time',
                              timeTextController: endTimeController,
                              onTimeChanged: viewModel.changeEndTime,
                              selectedTime: viewModel.endTime,
                              timeValidator: (value) =>
                                  ValidatorUtils.validateEndTime(
                                viewModel.startDate,
                                viewModel.startTime,
                                viewModel.endDate,
                                viewModel.endTime,
                              ),
                            ),
                            // Description
                            TaskFormField(
                              fieldTitle: 'Description',
                              fieldHint: 'Provide more details about the task',
                              textEditingController: descriptionController,
                              fieldMaxLines: 2,
                              validator: ValidatorUtils.validateEmpty,
                            ),
                            // Frequency
                            CreateTaskFrequency(
                              taskFrequency: viewModel.taskFrequency,
                              updateFrequency: viewModel.updateFrequency,
                            ),
                            // Color
                            CreateTaskColor(
                              taskColor: viewModel.taskColor,
                              updateColor: viewModel.updateColor,
                            ),
                            // Checklist
                            Text(
                              'Checklist',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverReorderableList(
                    itemCount: viewModel.taskCheckList.length,
                    onReorder: viewModel.reorderChecklist,
                    itemBuilder: (_, index) => Material(
                      key: ValueKey(viewModel.taskCheckList[index]),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 20, right: 10),
                        leading: ReorderableDragStartListener(
                          index: index,
                          child: Icon(
                            Icons.drag_handle,
                            color: context.colors.primary,
                            size: 24,
                          ),
                        ),
                        title: TextFormField(
                          initialValue: viewModel.taskCheckList[index],
                          onChanged: (text) =>
                              viewModel.updateChecklistText(index, text),
                          style: context.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Break down task into manageable steps',
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomIconButton.noBackground(
                                onTap: () =>
                                    viewModel.removeChecklistItem(index),
                                icon: const Icon(Icons.remove_rounded),
                                iconColor: viewModel.taskCheckList.length == 1
                                    ? context.colors.outline
                                    : context.colors.primary,
                                size: 20,
                              ),
                              CustomIconButton.noBackground(
                                onTap: () => viewModel.addChecklistItem(index),
                                icon: const Icon(Icons.add_rounded),
                                iconColor: context.colors.primary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: (context.isKeyboardOpen())
                  ? const SizedBox.shrink()
                  : PrimaryButton(
                      onTap: viewModel.updateTask,
                      margin: const EdgeInsets.all(20),
                      buttonText: 'Save Task',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  EditTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditTaskViewModel(oldTask: task);

  @override
  void onViewModelReady(EditTaskViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(EditTaskViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
