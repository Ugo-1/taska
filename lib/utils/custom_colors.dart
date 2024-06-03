import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? finch;
  final Color? onFinch;
  final Color? deepTeal;
  final Color? onDeepTeal;
  final Color? cetaceanBlue;
  final Color? onCetaceanBlue;
  final Color? plumpPurple;
  final Color? onPlumpPurple;
  final Color? russet;
  final Color? onRusset;
  final Color? bronze;
  final Color? onBronze;

  CustomColors({
    required this.finch,
    required this.onFinch,
    required this.deepTeal,
    required this.onDeepTeal,
    required this.cetaceanBlue,
    required this.onCetaceanBlue,
    required this.plumpPurple,
    required this.onPlumpPurple,
    required this.russet,
    required this.onRusset,
    required this.bronze,
    required this.onBronze,
  });

  @override
  ThemeExtension<CustomColors> lerp(
      ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      finch: Color.lerp(finch, other.finch, t),
      onFinch: Color.lerp(onFinch, other.finch, t),
      deepTeal: Color.lerp(deepTeal, other.deepTeal, t),
      onDeepTeal: Color.lerp(onDeepTeal, other.onDeepTeal, t),
      cetaceanBlue: Color.lerp(cetaceanBlue, other.cetaceanBlue, t),
      onCetaceanBlue: Color.lerp(onCetaceanBlue, other.onCetaceanBlue, t),
      plumpPurple: Color.lerp(plumpPurple, other.plumpPurple, t),
      onPlumpPurple: Color.lerp(onPlumpPurple, other.onPlumpPurple, t),
      russet: Color.lerp(russet, other.russet, t),
      onRusset: Color.lerp(onRusset, other.onRusset, t),
      bronze: Color.lerp(bronze, other.bronze, t),
      onBronze: Color.lerp(onBronze, other.onBronze, t),
    );
  }

  @override
  CustomColors copyWith({
    Color? finch,
    Color? onFinch,
    Color? deepTeal,
    Color? onDeepTeal,
    Color? cetaceanBlue,
    Color? onCetaceanBlue,
    Color? plumpPurple,
    Color? onPlumpPurple,
    Color? russet,
    Color? onRusset,
    Color? bronze,
    Color? onBronze,
  }) =>
      CustomColors(
        finch: finch ?? this.finch,
        onFinch: onFinch ?? this.onFinch,
        deepTeal: deepTeal ?? this.deepTeal,
        onDeepTeal: onDeepTeal ?? this.onDeepTeal,
        cetaceanBlue: cetaceanBlue ?? this.cetaceanBlue,
        onCetaceanBlue: onCetaceanBlue ?? this.onCetaceanBlue,
        plumpPurple: plumpPurple ?? this.plumpPurple,
        onPlumpPurple: onPlumpPurple ?? this.onPlumpPurple,
        russet: russet ?? this.russet,
        onRusset: onRusset ?? this.onRusset,
        bronze: bronze ?? this.bronze,
        onBronze: onBronze ?? this.onBronze,
      );
}
