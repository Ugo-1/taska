import 'package:flutter/material.dart';
import 'package:taska/utils/custom_colors.dart';

extension ThemeContext on BuildContext {
  ThemeData get _theme => Theme.of(this);

  TextTheme get textTheme => _theme.textTheme;

  ColorScheme get colors => _theme.colorScheme;

  CustomColors get customColors => _theme.extension<CustomColors>()!;

  bool isIOSPlatform() {
    final ThemeData theme = _theme;
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
    }
  }
}

extension ContextSize on BuildContext {
  double get deviceWidth => MediaQuery.sizeOf(this).width;

  double get deviceHeight => MediaQuery.sizeOf(this).height;

  double widthPercent(double value) {
    return (value / 100) * deviceWidth;
  }

  double heightPercent(double value) {
    return (value / 100) * deviceHeight;
  }

  bool isKeyboardOpen() => MediaQuery.viewInsetsOf(this).bottom > 0;

  bool isDarkMode() => MediaQuery.platformBrightnessOf(this) == Brightness.dark;

  double get getTextScaleFactor => MediaQuery.textScalerOf(this).scale(1);

  double tsfScale(
    double height, {
    double scaleFactor = 1,
    double? maxScaleFactor,
  }) {
    if (getTextScaleFactor == 1) {
      return height;
    }
    final textScaleFactor = (maxScaleFactor == null)
        ? getTextScaleFactor
        : getTextScaleFactor.clamp(0, maxScaleFactor);
    final heightFactorToUse = textScaleFactor * scaleFactor;
    double scaledHeight = height * heightFactorToUse;
    return scaledHeight;
  }

  double? tsfScaleNull(
    double? height, {
    double scaleFactor = 1,
    double? maxScaleFactor,
  }) {
    if (getTextScaleFactor == 1 || height == null) {
      return height;
    }
    return tsfScale(
      height,
      scaleFactor: scaleFactor,
      maxScaleFactor: maxScaleFactor,
    );
  }
}
