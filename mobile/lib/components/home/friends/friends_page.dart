import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements/custom-form-input.dart';
import 'package:split_buddy/components/elements/friend_card.dart';
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

  final TextEditingController searchController = TextEditingController();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorConstants.primaryColor,
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
            if (friends.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomFormInput(
                  controller: searchController,
                  labelText: 'Search...',
                  icon: Icons.search,
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: friends.isEmpty
                    ? Center(
                        child: Text(
                          'No friends added yet.',
                          style: TextStyle(
                              fontSize: 16, color: ColorConstants.whiteColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          return FriendCard(
                            username: friends[index]['username']!,
                            email: friends[index]['email']!,
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
