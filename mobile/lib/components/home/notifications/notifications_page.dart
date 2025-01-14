import 'package:flutter/material.dart';
import '../../../constants/color-constants.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Notifications'),
      ),
      body: Container(
        color: ColorConstants.homeBackgroundColor,
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
