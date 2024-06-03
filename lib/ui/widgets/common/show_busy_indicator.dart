import 'package:flutter/material.dart';
import 'package:taska/extensions/extension_exports.dart';

class ShowBusyIndicator extends StatelessWidget {
  final bool isBusy;
  final Widget child;

  const ShowBusyIndicator({
    super.key,
    required this.isBusy,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isBusy)
          ModalBarrier(
            dismissible: false,
            color: Colors.transparent.withOpacity(0.55),
          ),
        if (isBusy)
          Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
            ),
          ),
      ],
    );
  }
}
