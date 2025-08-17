import 'package:flutter/material.dart';

import '../../constants/color-constants.dart';
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
  final Widget? child; // <-- NOWE
  final String? circleText; // nowy parametr, opcjonalny

  const CustomButton({
    super.key,
    required this.style,
    required this.text,
    this.child, // <-- NOWE
    required this.onClick,
    required this.size,
    required this.fontSize,
    this.fontWeight,
    this.disabled = false,
    this.circleText, // <-- nowy
  });

  // Styl przycisku na podstawie stylu typu (Success, Delete, Outline)
  Color getBackgroundColor() {
    if (disabled) {
      return Colors.grey.shade400; // kolor dla disabled
    }
    switch (style) {
      case ButtonStyleType.Success:
        return ColorConstants.secondaryColor;
      case ButtonStyleType.Delete:
        return Colors.red;
      case ButtonStyleType.Outline:
        return Colors.transparent;
      case ButtonStyleType.Circle:
        return ColorConstants.primaryColor;
    }
  }

  Color getTextColor() {
    if (disabled) {
      return Colors.white.withOpacity(0.8); // trochę wyblakły tekst
    }
    return style == ButtonStyleType.Outline
        ? ColorConstants.primaryColor
        : Colors.white;
  }

  BorderSide getBorder() {
    if (style == ButtonStyleType.Outline) {
      return BorderSide(color: ColorConstants.primaryColor, width: 0.4);
    }
    return BorderSide.none;
  }

  // Rozmiary przycisku
  EdgeInsets getPadding() {
    switch (size) {
      case ButtonSize.S:
        return EdgeInsets.symmetric(vertical: 5, horizontal: 10);
      case ButtonSize.M:
        return EdgeInsets.symmetric(vertical: 14, horizontal: 22);
      case ButtonSize.L:
        return EdgeInsets.symmetric(vertical: 16, horizontal: 32);
      case ButtonSize.XL:
        return EdgeInsets.symmetric(vertical: 20, horizontal: 40);
    }
  }

  BorderRadius getBorderRadius() {
    switch (style) {
      case ButtonStyleType.Success:
        return BorderRadius.circular(8);
      case ButtonStyleType.Delete:
      case ButtonStyleType.Outline:
        return BorderRadius.circular(8); // mniejsze zaokrąglenie, np. 6
      case ButtonStyleType.Circle:
        return BorderRadius.circular(
            24); // to się nie używa, bo CircleGold ma BoxShape.circle
    }
  }

  double getCircleDiameter() {
    switch (size) {
      case ButtonSize.S:
        return 24;
      case ButtonSize.M:
        return 32;
      case ButtonSize.L:
        return 42;
      case ButtonSize.XL:
        return 50;
      default:
        return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (style == ButtonStyleType.Circle) {
      final double diameter = getCircleDiameter();

      return GestureDetector(
        onTap: disabled ? null : onClick,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            color: disabled
                ? Colors.grey.shade400
                : ColorConstants.primaryColor, // złoty kolor
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.close_rounded,
            color: disabled ? Colors.white.withOpacity(0.8) : Colors.black,
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: disabled ? null : onClick,
      style: OutlinedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        foregroundColor: getTextColor(),
        padding: getPadding(),
        side: getBorder(),
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius(),
        ),
      ),
      child: child ??
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize == ButtonFontSize.Small ? 12 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}

extension CustomButtonFactory on CustomButton {
  static Widget circleWithText({
    required String text,
    required VoidCallback onClick,
    ButtonSize size = ButtonSize.L,
    ButtonFontSize fontSize = ButtonFontSize.Medium,
    bool disabled = false,
  }) {
    double diameter;
    switch (size) {
      case ButtonSize.S:
        diameter = 24;
        break;
      case ButtonSize.M:
        diameter = 32;
        break;
      case ButtonSize.L:
        diameter = 42;
        break;
      case ButtonSize.XL:
        diameter = 50;
        break;
    }

    return GestureDetector(
      onTap: disabled ? null : onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color:
                  disabled ? Colors.grey.shade400 : ColorConstants.primaryColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.add, color: Colors.white, size: diameter * 0.5),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize == ButtonFontSize.Small ? 12 : 14,
                fontWeight: FontWeight.bold,
                color: disabled
                    ? Colors.grey.shade600
                    : ColorConstants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
