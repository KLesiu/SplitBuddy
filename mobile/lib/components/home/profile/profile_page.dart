import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/components/preload/preload.dart';
import '../../../services/httpService.dart';
import '../../../services/navigatorService.dart';
import '../../../stores/userStore.dart';
import '../../../constants/color-constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserStore userStore = UserStore();
  final HttpService httpService = HttpService();

  String? username;
  String? email;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      var response = await httpService.get("/api/User/getUser");
      if (response != null && response.body != null) {
        var body = jsonDecode(response.body);
        setState(() {
          username = body["username"];
          email = body["email"];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No user data available!';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong!';
        isLoading = false;
      });
    }
  }

  void logout(BuildContext context) async {
    await userStore.clearUser();
    NavigatorService.navigateTo(context, Preload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer( // menu po lewej
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorConstants.backgroundColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // dodaj akcję
              },
            ),
            // Możesz dodać więcej pozycji menu
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: ColorConstants.primaryColor),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // otwiera drawer
              },
            );
          },
        ),
        title: Text.rich(
          TextSpan(
            text: 'Welcome back, ',
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 20,
            ),
            children: [
              TextSpan(
                text: username ?? '...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 30, color: ColorConstants.primaryColor),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : errorMessage != null
            ? Center(
          child: Text(
            errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        )
            : Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      email ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
