import 'package:flutter/material.dart';

import 'profile_page_groups_header.dart';
import 'profile_page_groups_view.dart';

class ProfilePageGroups extends StatelessWidget {
  const ProfilePageGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ProfilePageGroupsHeader(),
        SizedBox(height: 16),
        ProfilePageGroupsView(),
      ],
    );
  }
}
