import 'package:flutter/material.dart';
import 'package:taska/enums/colors_enum.dart';
import 'package:taska/extensions/extension_exports.dart';

import 'create_task_item.dart';

class CreateTaskColor extends StatelessWidget {
  final ColorsEnum taskColor;
  final ValueChanged<ColorsEnum> updateColor;

  const CreateTaskColor({
    super.key,
    required this.taskColor,
    required this.updateColor,
  });

  @override
  Widget build(BuildContext context) {
    return CreateTaskItem(
      fieldTitle: 'Color',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ColorsEnum.values.map(
          (color) {
            final bool isSelected = taskColor == color;
            return Flexible(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: isSelected ? 1 : .8,
                child: GestureDetector(
                  onTap: () => updateColor(color),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: context.colors.primaryContainer,
                              width: 3,
                            )
                          : null,
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: color.getColors(context).$1,
                        ),
                        if (isSelected)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: context.colors.primaryContainer,
                              child: Icon(
                                Icons.check,
                                color: context.colors.onPrimaryContainer,
                                size: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
