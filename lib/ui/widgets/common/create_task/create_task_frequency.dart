import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';
import 'package:taska/ui/widgets/common/sizes.dart';

import 'create_task_item.dart';

class CreateTaskFrequency extends StatelessWidget {
  final List<int> taskFrequency;
  final ValueChanged<int> updateFrequency;

  const CreateTaskFrequency({
    super.key,
    required this.taskFrequency,
    required this.updateFrequency,
  });

  @override
  Widget build(BuildContext context) {
    return CreateTaskItem(
      fieldTitle: 'Frequency',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskFrequency.getTaskFrequency(),
            style: context.textTheme.bodySmall,
          ),
          const HSize(10),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: List.generate(
              7,
              (index) {
                index += 1;
                final bool isSelected = taskFrequency.contains(index);
                return InkWell(
                  onTap: () => updateFrequency(index),
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    type: MaterialType.transparency,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: isSelected
                          ? BoxDecoration(
                              color: context.colors.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            )
                          : null,
                      child: Text(
                        index.getDayOfWeekText(),
                        style: context.textTheme.labelSmall?.copyWith(
                            color: isSelected
                                ? context.colors.onPrimaryContainer
                                : context.colors.onBackground),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
