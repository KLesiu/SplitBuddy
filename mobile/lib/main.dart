import 'package:flutter/material.dart';
import 'package:split_buddy/components/preload/preload.dart';
import 'package:split_buddy/services/httpService.dart';
import 'package:split_buddy/stores/userStore.dart';
import 'components/home/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'enums/HttpResponses.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(App());
}

class App extends StatelessWidget {
  final UserStore userStore = UserStore();
  final HttpService httpService = HttpService();

  Future<Widget> validateToken() async {
    var response = await httpService.get("/api/User/checkToken");
    if(response?.statusCode == 400) return Preload();
    var result = response?.body;
    if (result == null || result == HttpResponses.unauthorized.message) {
      return Preload();
    }
    return Home();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplitBuddy',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Widget>(
        future: validateToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[700]!),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Center(
                child: Text(
                  'An error occurred: ${snapshot.error}',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Center(
                child: Text(
                  'Unexpected error occurred',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
