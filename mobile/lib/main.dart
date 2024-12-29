import 'package:flutter/material.dart';
import 'components/preload.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
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
