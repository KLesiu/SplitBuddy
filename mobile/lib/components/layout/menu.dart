// import 'package:flutter/material.dart';
// import 'package:split_buddy/constants/color-constants.dart';
//
// class Menu extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemTapped;
//
//   const Menu({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: ColorConstants.backgroundColor,
//       selectedItemColor: ColorConstants.secondaryColor,
//       unselectedItemColor: ColorConstants.primaryColor,
//       currentIndex: selectedIndex,
//       onTap: onItemTapped,
//       iconSize: 28,
//       selectedFontSize: 13,
//       unselectedFontSize: 12,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.group_outlined),
//           label: 'Groups',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications_none),
//           label: 'Notifications',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

class Menu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const Menu({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorConstants.backgroundColor,
      selectedItemColor: ColorConstants.secondaryColor,
      unselectedItemColor: ColorConstants.primaryColor,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      iconSize: 28,
      selectedFontSize: 13,
      unselectedFontSize: 12,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          label: 'Groups',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.people_outline),
        //   label: 'Friends',
        // ),
        // BottomNavigationBarItem(
        //   icon: Container(
        //     width: 52,
        //     height: 52,
        //     decoration: BoxDecoration(
        //       color: Color(0xFFBC9D5A),
        //       shape: BoxShape.circle, // Ustawienie okrągłego kształtu
        //     ),
        //     child: Icon(
        //       Icons.add,
        //       color: Colors.black,
        //       size: 36,
        //     ),
        //   ),
        //   label: '',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
      ],
    );
  }
}
