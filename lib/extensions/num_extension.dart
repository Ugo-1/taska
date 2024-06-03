import 'dart:math';

extension NumExtension on num {
  double convertToRotateRadians() => this * (pi / 180) / (2 * pi);

  String toPercent() => '${(this * 100).toInt()} %';
}