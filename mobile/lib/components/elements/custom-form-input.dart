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

  const CustomFormInput({
    required this.controller,
    required this.labelText,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: ColorConstants.primaryColor,
          fontWeight: FontWeight.w300, // Light font weight
        ),
        filled: true,
        fillColor: ColorConstants.cardBackgroundColor,
        prefixIcon: icon != null
            ? Icon(
          icon,
          color: ColorConstants.primaryColor,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixIconPressed,
          child: Icon(
            suffixIcon,
            color: ColorConstants.primaryColor,
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // 🎯 Zaokrąglone rogi
          borderSide: BorderSide(color: ColorConstants.primaryColor, width: 2),
        ),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
