import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_icon_button_model.dart';

class CustomIconButton extends StackedView<CustomIconButtonModel> {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Widget icon;
  final double size;
  final double iconSize;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
    required this.size,
    required this.iconSize,
    this.onTap,
    this.tooltip,
  });

  const CustomIconButton.noBackground({
    super.key,
    required this.icon,
    this.iconColor,
    required this.size,
    this.onTap,
    this.tooltip,
  })  : backgroundColor = null,
        iconSize = 0;

  @override
  Widget builder(
    BuildContext context,
    CustomIconButtonModel viewModel,
    Widget? child,
  ) {
    return AnimatedScale(
      scale: viewModel.scale,
      duration: viewModel.duration,
      curve: Curves.easeInOut,
      child: backgroundColor == null
          ? IconButton(
              onPressed: viewModel.onTap,
              alignment: Alignment.center,
              color: iconColor,
              tooltip: tooltip,
              iconSize: size,
              icon: icon,
            )
          : IconButton.filled(
              onPressed: viewModel.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                minimumSize: Size.square(size),
              ),
              alignment: Alignment.center,
              color: iconColor,
              highlightColor: Colors.transparent,
              iconSize: iconSize,
              tooltip: tooltip,
              icon: icon,
            ),
    );
  }

  @override
  CustomIconButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomIconButtonModel(onTap: onTap);
}
