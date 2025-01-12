import 'package:flutter/material.dart';
import 'package:split_buddy/components/home/payment/payment_page.dart';
import 'friends/friends_page.dart';
import 'groups/groups_page.dart';
import 'notifications/notifications_page.dart';
import 'profile/profile_page.dart';
import '../layout/menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();


}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }



  List<Widget> _pages() {
    return [
      GroupsPage(),
      FriendsPage(),
      PaymentPage(),
      NotificationsPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages()[_selectedIndex],
      ),
      bottomNavigationBar: Menu(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

