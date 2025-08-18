import 'package:flutter/material.dart';

import '../../../../constants/color-constants.dart';
import '../../../elements/custom-button.dart';
import '../../../elements/enums/button_font.dart';
import '../../../elements/enums/button_size.dart';
import '../../../elements/enums/button_style.dart';

class ProfilePageGroupsView extends StatelessWidget {
  const ProfilePageGroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista przycisków
    final List<Widget> buttons = [
      // Okrągły przycisk do dodawania nowej grupy
      CustomButtonFactory.circleWithText(
        text: "New group",
        onClick: () {
          // TODO: logika tworzenia nowej grupy
        },
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
      ),
      // Grupa 1
      CustomButton(
        style: ButtonStyleType.ProfileButton,
        text: "",
        onClick: () {},
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.beach_access,
                size: 30, color: ColorConstants.primaryColor),
            Text("Malaga",
                style:
                    TextStyle(fontSize: 12, color: ColorConstants.whiteColor)),
          ],
        ),
      ),
      // Grupa 2
      CustomButton(
        style: ButtonStyleType.ProfileButton,
        text: "",
        onClick: () {},
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 30, color: ColorConstants.primaryColor),
            Text("Home",
                style:
                    TextStyle(fontSize: 12, color: ColorConstants.whiteColor)),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ✅ równe odstępy
        children: buttons,
      ),
    );
  }
}
