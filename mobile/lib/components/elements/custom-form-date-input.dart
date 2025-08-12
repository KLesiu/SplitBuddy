import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/color-constants.dart';

class CustomFormDateInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final IconData icon;

  const CustomFormDateInput({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.icon = Icons.calendar_today,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus(); // zamyka klawiaturę

        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: ColorConstants.cardBackgroundColor,
                colorScheme: ColorScheme.dark(
                  primary: ColorConstants.primaryColor,
                  onSurface: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      child: AbsorbPointer(
        // uniemożliwia ręczne wpisywanie daty
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: ColorConstants.primaryColor,
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: ColorConstants.cardBackgroundColor,
            prefixIcon: Icon(icon, color: ColorConstants.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorConstants.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorConstants.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: ColorConstants.primaryColor, width: 2),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}