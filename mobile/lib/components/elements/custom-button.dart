import 'package:flutter/material.dart';

import 'enums/button_size.dart';
import 'enums/button_style.dart';

class CustomButton extends StatelessWidget {
  final ButtonStyleType style;
  final String text;
  final VoidCallback onClick;
  final ButtonSize size;

  const CustomButton({
    super.key,
    required this.style,
    required this.text,
    required this.onClick,
    required this.size,
  });

  // Styl przycisku na podstawie stylu typu (Success, Delete, Outline)
  Color _getBackgroundColor() {
    switch (style) {
      case ButtonStyleType.Success:
        return Colors.green;
      case ButtonStyleType.Delete:
        return Colors.red;
      case ButtonStyleType.Outline:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    return style == ButtonStyleType.Outline ? Colors.black : Colors.white;
  }

  BorderSide _getBorder() {
    if (style == ButtonStyleType.Outline) {
      return BorderSide(color: Colors.black, width: 2);
    }
    return BorderSide.none;
  }

  // Rozmiary przycisku
  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.M:
        return EdgeInsets.symmetric(vertical: 12, horizontal: 24);
      case ButtonSize.L:
        return EdgeInsets.symmetric(vertical: 16, horizontal: 32);
      case ButtonSize.XL:
        return EdgeInsets.symmetric(vertical: 20, horizontal: 40);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getTextColor(),
        padding: _getPadding(),
        side: _getBorder(),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _getTextColor(),
        ),
      ),
    );
  }
}

//Przykład użycia!

// CustomButton(
// style: ButtonStyleType.Success,
// text: 'Zapisz',
// onClick: () {
// print('Kliknięto przycisk!');
// },
// size: ButtonSize.M,
// ),
