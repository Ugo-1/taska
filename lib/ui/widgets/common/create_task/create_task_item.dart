import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

class CreateTaskItem extends StatelessWidget {
  final String fieldTitle;
  final Widget child;
  const CreateTaskItem({
    super.key,
    required this.fieldTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.primary,
          ),
        ),
        const HSize(10),
        child,
        const HSize(20),
      ],
    );
  }
}
