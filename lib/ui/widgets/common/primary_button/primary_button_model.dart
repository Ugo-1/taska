import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class PrimaryButtonModel extends BaseViewModel {
  final VoidCallback? _onTap;

  PrimaryButtonModel({VoidCallback? onTap}) : _onTap = onTap;

  double scale = 1;
  final Duration duration = const Duration(milliseconds: 200);

  void _changeButtonScale(double size) {
    scale = size;
    rebuildUi();
  }

  void onTap() async {
    if (_onTap == null) return;
    _changeButtonScale(.8);
    await Future.delayed(duration, _onTap);
    _changeButtonScale(1);
  }

  void onLongPress(bool isStart) {
    if (isStart) {
      _changeButtonScale(.8);
    } else {
      _changeButtonScale(1);
    }
  }
}
