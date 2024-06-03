import 'package:flutter/cupertino.dart';
import 'package:taska/enums/colors_enum.dart';
import 'package:taska/extensions/context_extension.dart';
import 'package:taska/utils/custom_colors.dart';

extension ColorsEnumThemeExtension on ColorsEnum {
  /// This returns the background color and the foreground color for the
  /// task custom colors
  (Color?, Color?) getColors(BuildContext context) {
    final CustomColors colors = context.customColors;
    return switch (this) {
      ColorsEnum.finch => (colors.finch, colors.onFinch),
      ColorsEnum.deepTeal => (colors.deepTeal, colors.onDeepTeal),
      ColorsEnum.cetaceanBlue => (colors.cetaceanBlue, colors.onCetaceanBlue),
      ColorsEnum.plumpPurple => (colors.plumpPurple, colors.onPlumpPurple),
      ColorsEnum.russet => (colors.russet, colors.onRusset),
      ColorsEnum.bronze => (colors.bronze, colors.onBronze),
    };
  }

  /// This returns the name of the color
  String getColorName() {
    return switch (this) {
      ColorsEnum.finch => 'Finch',
      ColorsEnum.deepTeal => 'Deep Teal',
      ColorsEnum.cetaceanBlue => 'Cetacean Blue',
      ColorsEnum.plumpPurple => 'Plump Purple',
      ColorsEnum.russet => 'Russet',
      ColorsEnum.bronze => 'Bronze',
    };
  }
}
