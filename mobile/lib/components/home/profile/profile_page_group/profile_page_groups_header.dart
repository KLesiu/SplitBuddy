import 'package:flutter/material.dart';

import '../../../../constants/color-constants.dart';
import '../../../elements/custom-button.dart';
import '../../../elements/enums/button_font.dart';
import '../../../elements/enums/button_size.dart';
import '../../../elements/enums/button_style.dart';

class ProfilePageGroupsHeader extends StatelessWidget {
  const ProfilePageGroupsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ pełna szerokość ekranu
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: ColorConstants.blackColor, // 🎨 kolor tła nagłówka
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My groups",
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.greyColor, // dopasowany do ciemnego tła
            ),
          ),
          CustomButton(
            style: ButtonStyleType.Outline,
            text: "View all >",
            onClick: () {
              // TODO: nawigacja do listy wszystkich grup
            },
            size: ButtonSize.M,
            fontSize: ButtonFontSize.Medium,
          ),
        ],
      ),
    );
  }
}
