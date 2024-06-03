import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

class TaskDetailContent extends StatelessWidget {
  final String title;
  final String detail;
  final Color? taskColor;
  final Widget? trailing;

  const TaskDetailContent({
    super.key,
    required this.title,
    required this.detail,
    required this.taskColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.primary,
          ),
        ),
        const HSize(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                detail,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (trailing != null) ...[
              const WSize(10),
              trailing!,
            ],
          ],
        ),
        const HSize(8),
        Divider(
          color: taskColor,
        ),
        const HSize(20),
      ],
    );
  }
}
