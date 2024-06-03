enum ScreenSizeEnum {
  // Phone in portrait
  compact(maxWidth: 600),
  // Tablet in portrait or Foldable in portrait (unfolded)
  medium(maxWidth: 840),
  // Tablet in landscape or Foldable in landscape (unfolded) or Desktop
  expanded(maxWidth: 1200),
  // Desktop, TV
  large(maxWidth: 1600);

  const ScreenSizeEnum({required this.maxWidth});

  final double maxWidth;

  bool isSmallerThan(double screenWidth) => screenWidth < maxWidth;

  factory ScreenSizeEnum.getScreenSize(double screenWidth) {
    if (ScreenSizeEnum.compact.isSmallerThan(
      screenWidth,
    )) {
      return ScreenSizeEnum.compact;
    } else if (ScreenSizeEnum.medium.isSmallerThan(
      screenWidth,
    )) {
      return ScreenSizeEnum.medium;
    } else if (ScreenSizeEnum.expanded.isSmallerThan(
      screenWidth,
    )) {
      return ScreenSizeEnum.expanded;
    } else {
      return ScreenSizeEnum.large;
    }
  }
}
