// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TaskNameValueKey = 'taskName';
const String StartDateValueKey = 'startDate';
const String StartTimeValueKey = 'startTime';
const String EndDateValueKey = 'endDate';
const String EndTimeValueKey = 'endTime';
const String DescriptionValueKey = 'description';

final Map<String, TextEditingController> _EditTaskViewTextEditingControllers =
    {};

final Map<String, FocusNode> _EditTaskViewFocusNodes = {};

final Map<String, String? Function(String?)?> _EditTaskViewTextValidations = {
  TaskNameValueKey: null,
  StartDateValueKey: null,
  StartTimeValueKey: null,
  EndDateValueKey: null,
  EndTimeValueKey: null,
  DescriptionValueKey: null,
};

mixin $EditTaskView {
  TextEditingController get taskNameController =>
      _getFormTextEditingController(TaskNameValueKey);
  TextEditingController get startDateController =>
      _getFormTextEditingController(StartDateValueKey);
  TextEditingController get startTimeController =>
      _getFormTextEditingController(StartTimeValueKey);
  TextEditingController get endDateController =>
      _getFormTextEditingController(EndDateValueKey);
  TextEditingController get endTimeController =>
      _getFormTextEditingController(EndTimeValueKey);
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);

  FocusNode get taskNameFocusNode => _getFormFocusNode(TaskNameValueKey);
  FocusNode get startDateFocusNode => _getFormFocusNode(StartDateValueKey);
  FocusNode get startTimeFocusNode => _getFormFocusNode(StartTimeValueKey);
  FocusNode get endDateFocusNode => _getFormFocusNode(EndDateValueKey);
  FocusNode get endTimeFocusNode => _getFormFocusNode(EndTimeValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_EditTaskViewTextEditingControllers.containsKey(key)) {
      return _EditTaskViewTextEditingControllers[key]!;
    }

    _EditTaskViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EditTaskViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EditTaskViewFocusNodes.containsKey(key)) {
      return _EditTaskViewFocusNodes[key]!;
    }
    _EditTaskViewFocusNodes[key] = FocusNode();
    return _EditTaskViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    taskNameController.addListener(() => _updateFormData(model));
    startDateController.addListener(() => _updateFormData(model));
    startTimeController.addListener(() => _updateFormData(model));
    endDateController.addListener(() => _updateFormData(model));
    endTimeController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    taskNameController.addListener(() => _updateFormData(model));
    startDateController.addListener(() => _updateFormData(model));
    startTimeController.addListener(() => _updateFormData(model));
    endDateController.addListener(() => _updateFormData(model));
    endTimeController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TaskNameValueKey: taskNameController.text,
          StartDateValueKey: startDateController.text,
          StartTimeValueKey: startTimeController.text,
          EndDateValueKey: endDateController.text,
          EndTimeValueKey: endTimeController.text,
          DescriptionValueKey: descriptionController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _EditTaskViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EditTaskViewFocusNodes.values) {
      focusNode.dispose();
    }

    _EditTaskViewTextEditingControllers.clear();
    _EditTaskViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get taskNameValue => this.formValueMap[TaskNameValueKey] as String?;
  String? get startDateValue => this.formValueMap[StartDateValueKey] as String?;
  String? get startTimeValue => this.formValueMap[StartTimeValueKey] as String?;
  String? get endDateValue => this.formValueMap[EndDateValueKey] as String?;
  String? get endTimeValue => this.formValueMap[EndTimeValueKey] as String?;
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;

  set taskNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TaskNameValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(TaskNameValueKey)) {
      _EditTaskViewTextEditingControllers[TaskNameValueKey]?.text = value ?? '';
    }
  }

  set startDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StartDateValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(StartDateValueKey)) {
      _EditTaskViewTextEditingControllers[StartDateValueKey]?.text =
          value ?? '';
    }
  }

  set startTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StartTimeValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(StartTimeValueKey)) {
      _EditTaskViewTextEditingControllers[StartTimeValueKey]?.text =
          value ?? '';
    }
  }

  set endDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EndDateValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(EndDateValueKey)) {
      _EditTaskViewTextEditingControllers[EndDateValueKey]?.text = value ?? '';
    }
  }

  set endTimeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EndTimeValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(EndTimeValueKey)) {
      _EditTaskViewTextEditingControllers[EndTimeValueKey]?.text = value ?? '';
    }
  }

  set descriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({DescriptionValueKey: value}),
    );

    if (_EditTaskViewTextEditingControllers.containsKey(DescriptionValueKey)) {
      _EditTaskViewTextEditingControllers[DescriptionValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasTaskName =>
      this.formValueMap.containsKey(TaskNameValueKey) &&
      (taskNameValue?.isNotEmpty ?? false);
  bool get hasStartDate =>
      this.formValueMap.containsKey(StartDateValueKey) &&
      (startDateValue?.isNotEmpty ?? false);
  bool get hasStartTime =>
      this.formValueMap.containsKey(StartTimeValueKey) &&
      (startTimeValue?.isNotEmpty ?? false);
  bool get hasEndDate =>
      this.formValueMap.containsKey(EndDateValueKey) &&
      (endDateValue?.isNotEmpty ?? false);
  bool get hasEndTime =>
      this.formValueMap.containsKey(EndTimeValueKey) &&
      (endTimeValue?.isNotEmpty ?? false);
  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);

  bool get hasTaskNameValidationMessage =>
      this.fieldsValidationMessages[TaskNameValueKey]?.isNotEmpty ?? false;
  bool get hasStartDateValidationMessage =>
      this.fieldsValidationMessages[StartDateValueKey]?.isNotEmpty ?? false;
  bool get hasStartTimeValidationMessage =>
      this.fieldsValidationMessages[StartTimeValueKey]?.isNotEmpty ?? false;
  bool get hasEndDateValidationMessage =>
      this.fieldsValidationMessages[EndDateValueKey]?.isNotEmpty ?? false;
  bool get hasEndTimeValidationMessage =>
      this.fieldsValidationMessages[EndTimeValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;

  String? get taskNameValidationMessage =>
      this.fieldsValidationMessages[TaskNameValueKey];
  String? get startDateValidationMessage =>
      this.fieldsValidationMessages[StartDateValueKey];
  String? get startTimeValidationMessage =>
      this.fieldsValidationMessages[StartTimeValueKey];
  String? get endDateValidationMessage =>
      this.fieldsValidationMessages[EndDateValueKey];
  String? get endTimeValidationMessage =>
      this.fieldsValidationMessages[EndTimeValueKey];
  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
}

extension Methods on FormStateHelper {
  setTaskNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TaskNameValueKey] = validationMessage;
  setStartDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StartDateValueKey] = validationMessage;
  setStartTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StartTimeValueKey] = validationMessage;
  setEndDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EndDateValueKey] = validationMessage;
  setEndTimeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EndTimeValueKey] = validationMessage;
  setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    taskNameValue = '';
    startDateValue = '';
    startTimeValue = '';
    endDateValue = '';
    endTimeValue = '';
    descriptionValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TaskNameValueKey: getValidationMessage(TaskNameValueKey),
      StartDateValueKey: getValidationMessage(StartDateValueKey),
      StartTimeValueKey: getValidationMessage(StartTimeValueKey),
      EndDateValueKey: getValidationMessage(EndDateValueKey),
      EndTimeValueKey: getValidationMessage(EndTimeValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _EditTaskViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _EditTaskViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TaskNameValueKey: getValidationMessage(TaskNameValueKey),
      StartDateValueKey: getValidationMessage(StartDateValueKey),
      StartTimeValueKey: getValidationMessage(StartTimeValueKey),
      EndDateValueKey: getValidationMessage(EndDateValueKey),
      EndTimeValueKey: getValidationMessage(EndTimeValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });
