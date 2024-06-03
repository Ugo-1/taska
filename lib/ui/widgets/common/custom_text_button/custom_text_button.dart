import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_text_button_model.dart';

class CustomTextButton extends StackedView<CustomTextButtonModel> {
  final String text;
  final TextStyle? textStyle;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Size? minimumSize;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;
  final String? tooltip;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.textStyle,
    this.shape,
    this.backgroundColor,
    this.minimumSize,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.tooltip,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTextButtonModel viewModel,
    Widget? child,
  ) {
    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: margin,
        child: AnimatedScale(
          scale: viewModel.scale,
          duration: viewModel.duration,
          curve: Curves.easeInOut,
          child: TextButton(
            onPressed: viewModel.onTap,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: shape,
              minimumSize: minimumSize,
            ),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  CustomTextButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextButtonModel(onTap: onTap);
}
