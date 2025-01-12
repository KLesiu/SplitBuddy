import 'package:flutter/material.dart';
import 'package:split_buddy/components/preload/preload.dart';
import '../../../services/navigatorService.dart';
import '../../../stores/userStore.dart';

class ProfilePage extends StatelessWidget {
  final UserStore userStore = UserStore();

  void logout(context) async{
      await userStore.clearUser();
      NavigatorService.navigateTo(context, Preload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 30, color: Colors.amber[700]),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Profile content here',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
