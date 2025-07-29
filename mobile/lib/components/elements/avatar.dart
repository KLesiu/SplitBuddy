import 'package:flutter/material.dart';
import '../../../constants/color-constants.dart';


class Avatar extends StatelessWidget {
  // 🔹 Mockowane dane użytkownika
  final String firstName = "Jan";
  final String lastName = "Dąbrowski";

  Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔸 Wyciąganie inicjałów
    String initials = "${firstName[0]}${lastName[0]}".toUpperCase();

    return CircleAvatar(
      radius: 40, // Rozmiar avatara
      backgroundColor: ColorConstants.primaryColor, // Kolor tła
      child: Text(
        initials,
        style: TextStyle(
          color: ColorConstants.blackColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
