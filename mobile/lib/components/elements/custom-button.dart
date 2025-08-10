import 'package:flutter/material.dart';

import 'enums/button_font.dart';
import 'enums/button_size.dart';
import 'enums/button_style.dart';

class CustomButton extends StatelessWidget {
  final ButtonStyleType style;
  final String text;
  final VoidCallback onClick;
  final ButtonSize size;
  final FontWeight? fontWeight;
  final bool disabled;
  final ButtonFontSize fontSize;

  const CustomButton({
    super.key,
    required this.style,
    required this.text,
    required this.onClick,
    required this.size,
    required this.fontSize,
    this.fontWeight,
    this.disabled = false,
  });

  // Styl przycisku na podstawie stylu typu (Success, Delete, Outline)
  Color getBackgroundColor() {
    if (disabled) {
      return Colors.grey.shade400; // kolor dla disabled
    }
    switch (style) {
      case ButtonStyleType.Success:
        return Colors.green;
      case ButtonStyleType.Delete:
        return Colors.red;
      case ButtonStyleType.Outline:
        return Colors.transparent;
    }
  }

  Color getTextColor() {
    if (disabled) {
      return Colors.white.withOpacity(0.8); // trochę wyblakły tekst
    }
    return style == ButtonStyleType.Outline ? Colors.black : Colors.white;
  }

  BorderSide getBorder() {
    if (style == ButtonStyleType.Outline) {
      return BorderSide(color: Colors.black, width: 2);
    }
    return BorderSide.none;
  }

  // Rozmiary przycisku
  EdgeInsets getPadding() {
    switch (size) {
      case ButtonSize.M:
        return EdgeInsets.symmetric(vertical: 12, horizontal: 24);
      case ButtonSize.L:
        return EdgeInsets.symmetric(vertical: 16, horizontal: 32);
      case ButtonSize.XL:
        return EdgeInsets.symmetric(vertical: 20, horizontal: 40);
    }
  }

  // Dynamiczny fontSize
  double getFontSize() {
    switch (size) {
      case ButtonSize.M:
        return 14;
      case ButtonSize.L:
        return 16;
      case ButtonSize.XL:
        return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: disabled ? null : onClick,
      style: OutlinedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        foregroundColor: getTextColor(),
        padding: getPadding(),
        side: getBorder(),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize.value,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: getTextColor(),
        ),
      ),
    );
  }
}
