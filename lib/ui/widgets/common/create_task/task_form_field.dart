import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/create_task/create_task_item.dart';

class TaskFormField extends StatelessWidget {
  final String fieldTitle, fieldHint;
  final TextEditingController textEditingController;
  final int fieldMaxLines;
  final bool excludeFieldFocus, enableInteractiveSelection;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const TaskFormField({
    super.key,
    required this.fieldTitle,
    required this.fieldHint,
    required this.textEditingController,
    this.fieldMaxLines = 1,
    this.excludeFieldFocus = false,
    this.enableInteractiveSelection = true,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CreateTaskItem(
      fieldTitle: fieldTitle,
      child: ExcludeFocus(
        excluding: excludeFieldFocus,
        child: TextFormField(
          controller: textEditingController,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          enableInteractiveSelection: enableInteractiveSelection,
          textCapitalization: TextCapitalization.sentences,
          maxLines: fieldMaxLines,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: fieldHint,
            suffixIcon: suffixIcon,
            errorMaxLines: 3,
          ),
          validator: validator,
          autovalidateMode: validator == null ? null : AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
