import 'package:flutter/material.dart';

import '../../constants/color-constants.dart';
import 'avatar.dart';
import 'custom-button.dart';
import 'enums/button_font.dart';
import 'enums/button_size.dart';
import 'enums/button_style.dart';

class FriendOption extends StatelessWidget {
  final String name;
  final String surname;
  final VoidCallback onTap;

  const FriendOption({
    Key? key,
    required this.name,
    required this.surname,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Avatar(
              firstName: name,
              lastName: surname,
              size: 32,
            ), // teraz imię i nazwisko dynamiczne
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$name $surname",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.greyColor),
              ),
            ),
            CustomButton(
              style: ButtonStyleType.Circle, // albo inny styl
              text: "Add",
              size: ButtonSize.S, // rozmiar przycisku
              fontSize: ButtonFontSize.Medium, // rozmiar czcionki
              onClick: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
