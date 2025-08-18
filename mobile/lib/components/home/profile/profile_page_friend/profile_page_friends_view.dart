import 'package:flutter/material.dart';

import '../../../elements/avatar_text.dart';
import '../../../elements/custom-button.dart';
import '../../../elements/enums/button_font.dart';
import '../../../elements/enums/button_size.dart';
import '../../../elements/enums/button_style.dart';

class ProfilePageFriendsView extends StatelessWidget {
  const ProfilePageFriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Przyciski do wyświetlenia
    final List<Widget> buttons = [
      CustomButtonFactory.circleWithText(
        text: "Add friend",
        onClick: () {
// TODO: logika dodawania znajomego
        },
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
      ),
      CustomButton(
        style: ButtonStyleType.ProfileButton,
        text: "",
        onClick: () {},
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
        child: const AvatarText(firstName: "John", lastName: "Doe"),
      ),
      CustomButton(
        style: ButtonStyleType.ProfileButton,
        text: "",
        onClick: () {},
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
        child: const AvatarText(firstName: "Alice", lastName: "Smith"),
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
