enum ButtonFontSize {
  Small,
  Medium,
  Large,
}

extension ButtonFontSizeExtension on ButtonFontSize {
  double get value {
    switch (this) {
      case ButtonFontSize.Small:
        return 14.0;
      case ButtonFontSize.Medium:
        return 16.0;
      case ButtonFontSize.Large:
        return 18.0;
    }
  }
}
