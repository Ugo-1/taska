import 'package:flutter/material.dart';
import 'package:taska/enums/screen_size_enum.dart';
import 'package:taska/utils/types.dart';

class ScreenLayout extends StatelessWidget {
  final CustomLayoutBuilder compactLayout;
  final CustomLayoutBuilder? mediumLayout;
  final CustomLayoutBuilder? expandedLayout;
  final CustomLayoutBuilder? largeLayout;

  const ScreenLayout({
    super.key,
    required this.compactLayout,
    this.mediumLayout,
    this.expandedLayout,
    this.largeLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final ScreenSizeEnum screenSizeEnum =
            ScreenSizeEnum.getScreenSize(constraints.maxWidth);
        return switch (screenSizeEnum) {
          ScreenSizeEnum.compact => compactLayout(context),
          ScreenSizeEnum.medium =>
            mediumLayout?.call(context) ?? compactLayout(context),
          ScreenSizeEnum.expanded => expandedLayout?.call(context) ??
              mediumLayout?.call(context) ??
              compactLayout(context),
          ScreenSizeEnum.large => largeLayout?.call(context) ??
              expandedLayout?.call(context) ??
              mediumLayout?.call(context) ??
              compactLayout(context),
        };
      },
    );
  }
}
