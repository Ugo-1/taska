import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class CustomIconButtonModel extends BaseViewModel {
  final VoidCallback? _onTap;

  CustomIconButtonModel({VoidCallback? onTap}) : _onTap = onTap;

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
}
