import 'package:flutter/material.dart';

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
        style: ButtonStyleType.Outline,
        text: "",
        onClick: () {},
        size: ButtonSize.L,
        fontSize: ButtonFontSize.Medium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.group, size: 32, color: Colors.black87),
            SizedBox(height: 4),
            Text("Trip to Rome",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      // Grupa 2
      CustomButton(
        style: ButtonStyleType.Outline,
        text: "",
        onClick: () {},
        size: ButtonSize.S,
        fontSize: ButtonFontSize.Medium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.group, size: 32, color: Colors.black87),
            SizedBox(height: 4),
            Text("Weekend BBQ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ];

    return SizedBox(
      height: 100, // stała wysokość sekcji
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: buttons.length,
        itemBuilder: (context, index) => buttons[index],
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    );
  }
}
