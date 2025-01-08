import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(
          'Notifications content here',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
