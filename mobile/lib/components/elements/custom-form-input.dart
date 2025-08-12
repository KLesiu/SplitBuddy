import 'package:flutter/material.dart';

import '../../constants/color-constants.dart';

class CustomFormInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final Color? fillColor;

  const CustomFormInput({
    required this.controller,
    required this.labelText,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.fillColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: ColorConstants.whiteColor,
          fontWeight: FontWeight.w300, // Light font weight
        ),
        filled: true,
        fillColor: fillColor ?? ColorConstants.cardBackgroundColor,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: ColorConstants.whiteColor,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconPressed,
                child: Icon(
                  suffixIcon,
                  color: ColorConstants.whiteColor,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.primaryColor, width: 2),
        ),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
