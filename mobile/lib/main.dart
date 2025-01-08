import 'package:flutter/material.dart';
import 'components/home/home.dart';
import 'components/preload/preload.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
