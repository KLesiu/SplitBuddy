import 'package:flutter/material.dart';
import '../../../constants/color-constants.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        title: Text(
          'Notifications',
          style: TextStyle(color: ColorConstants.primaryColor), // Ustawienie koloru
        ),

      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Center(
          child: Text(
            'Notifications content here',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
