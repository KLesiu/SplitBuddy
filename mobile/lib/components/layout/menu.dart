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
    final screenHeight = MediaQuery.of(context).size.height;
    final barHeight = screenHeight * 0.07; // np. 9% wysokości ekranu

    return SizedBox(
      height: barHeight,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorConstants.backgroundColor,
        selectedItemColor: ColorConstants.secondaryColor,
        unselectedItemColor: ColorConstants.primaryColor,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 22),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
