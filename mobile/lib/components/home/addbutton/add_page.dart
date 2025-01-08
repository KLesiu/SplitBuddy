import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Add'),
      ),
      body: Center(
        child: Icon(
          Icons.add_circle_outline,
          size: 100,
          color: Color(0xFFC4A663),
        ),
      ),
    );
  }
}
