import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xFF4EA95F),
      selectedItemColor: Color(0xFFC4A663),
      unselectedItemColor: Colors.white,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Color(0xFFBC9D5A),
              shape: BoxShape.circle, // Ustawienie okrągłego kształtu
            ),
            child: Icon(Icons.add, color: Colors.black, size: 32),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
