import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements/avatar_widget.dart';
import 'package:split_buddy/components/elements/custom-form-input.dart';
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
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: ColorConstants.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color:
                                    ColorConstants.primaryColor, // kolor ramki
                                width: 0.7, // grubość ramki
                              ),
                            ),
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // centrowanie pionowe
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        16.0), // równe odstępy dookoła avatara
                                    child: AvatarWidget(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              16.0), // pionowe odstępy dla tekstu
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            friends[index]['username']!,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: ColorConstants.whiteColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'Email: ${friends[index]['email']}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: ColorConstants.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
