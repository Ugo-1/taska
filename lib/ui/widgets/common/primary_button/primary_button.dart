import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:taska/extensions/context_extension.dart';

import 'primary_button_model.dart';

class PrimaryButton extends StackedView<PrimaryButtonModel> {
  final VoidCallback? onTap;
  final String buttonText;
  final String? semanticLabel;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final TextStyle? buttonTextStyle;
  final Color? backgroundColor;
  final double borderRadius;
  final BoxConstraints? boxConstraints;
  final int? maxLines;
  final double? width;
  final bool isFilled;
  final BoxBorder? border;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.semanticLabel,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(14),
    this.borderRadius = 10,
    this.buttonTextStyle,
    this.backgroundColor,
    this.boxConstraints,
    this.maxLines,
    this.width,
    this.isFilled = true,
    this.border,
  });

  const PrimaryButton.outline({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.semanticLabel,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(14),
    this.borderRadius = 10,
    this.buttonTextStyle,
    this.boxConstraints,
    this.maxLines,
    this.width,
    this.border,
  })  : isFilled = false,
        backgroundColor = Colors.transparent;

  @override
  Widget builder(
    BuildContext context,
    PrimaryButtonModel viewModel,
    Widget? child,
  ) {
    return AnimatedScale(
      scale: viewModel.scale,
      duration: viewModel.duration,
      child: Semantics(
        label: semanticLabel ?? buttonText,
        button: true,
        excludeSemantics: true,
        child: DefaultTextStyle.merge(
          style: buttonTextStyle ??
              context.textTheme.bodyMedium?.copyWith(
                color: isFilled
                    ? context.colors.onPrimary
                    : context.colors.onBackground,
              ),
          maxLines: maxLines,
          child: GestureDetector(
            onTap: viewModel.onTap,
            onLongPress: () => viewModel.onLongPress(true),
            onLongPressUp: () => viewModel.onLongPress(false),
            child: Container(
              margin: margin,
              padding: padding,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor ?? context.colors.primary,
                borderRadius: BorderRadius.circular(borderRadius),
                border: !isFilled
                    ? border ?? Border.all(color: context.colors.primary)
                    : null,
              ),
              clipBehavior: Clip.hardEdge,
              constraints: boxConstraints,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PrimaryButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrimaryButtonModel(onTap: onTap);
}
