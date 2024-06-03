import 'package:flutter/material.dart';

class HSize extends StatelessWidget {
  final double size;
  const HSize(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class WSize extends StatelessWidget {
  final double size;
  const WSize(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
