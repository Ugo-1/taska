import 'package:flutter/cupertino.dart';

enum PrimaryModelEnum {
  normal,
  permissionDenied;
}

class PrimaryModalModel {
  final IconData icon;
  final String title;
  final String description;
  final String? mainButtonTitle;
  final String? secondaryButtonTitle;
  final PrimaryModelEnum modelType;

  const PrimaryModalModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.modelType,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
  });
}
