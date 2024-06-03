import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class CustomTextButtonModel extends BaseViewModel {
  final VoidCallback? _onTap;

  CustomTextButtonModel({VoidCallback? onTap}) : _onTap = onTap;

  double scale = 1;
  final Duration duration = const Duration(milliseconds: 200);
  final Duration _onTapDuration = const Duration(milliseconds: 100);

  void _changeButtonScale(double size) {
    scale = size;
    rebuildUi();
  }

  void onTap() async {
    if (_onTap == null) return;
    _changeButtonScale(.7);
    await Future.delayed(_onTapDuration, _onTap);
    _changeButtonScale(1);
  }
}
