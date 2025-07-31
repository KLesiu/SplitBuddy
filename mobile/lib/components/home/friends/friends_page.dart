import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/components/home/friends/add_friend_widget.dart';
import 'package:split_buddy/constants/color-constants.dart';

import '../../../services/httpService.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final HttpService httpService = HttpService();
  List<Map<String, dynamic>> friends = [];

  void getFriends() async {
    var response = await httpService.get("/api/Friendship/getFriends");
    if (response == null) return;
    var result = jsonDecode(response.body);
    if (result != null && result is List) {
      setState(() {
        friends = List<Map<String, dynamic>>.from(result as Iterable);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        title: Text(
          'Friends',
          style: TextStyle(
              color: ColorConstants.primaryColor), // Ustawienie koloru
        ),
      ),
      body: Container(
        color: ColorConstants.backgroundColor, // Ustawienie tła
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: friends.isEmpty
                    ? Center(
                        child: Text(
                          'No friends added yet.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color(0xFF4EA95F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFFC4A663),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              title: Text(
                                friends[index]['username']!,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              subtitle: Text(
                                'Email: ${friends[index]['email']}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddFriendWidget(
        onFriendAdded: getFriends,
      ),
    );
  }
}
