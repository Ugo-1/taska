import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

class TaskDetailHeader extends StatelessWidget {
  final String title;
  final String detail;
  final Color? color;

  const TaskDetailHeader({
    super.key,
    required this.title,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                color: color,
              ),
            ),
          ),
          const WSize(10),
          Expanded(
            flex: 4,
            child: Text(
              detail,
              style: context.textTheme.bodyMedium?.copyWith(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
