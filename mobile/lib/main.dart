import 'package:flutter/material.dart';
import 'components/preload.dart';
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplitBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Preload(),
    );
  }
}
