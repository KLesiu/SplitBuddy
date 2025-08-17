import 'package:flutter/material.dart';

import 'profile_page_friends_header.dart';
import 'profile_page_friends_view.dart';

class ProfilePageFriends extends StatelessWidget {
  const ProfilePageFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ProfilePageFriendsHeader(),
        SizedBox(height: 16),
        ProfilePageFriendsView(),
      ],
    );
  }
}
