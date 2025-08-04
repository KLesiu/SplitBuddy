import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import 'avatar.dart';

class FriendCard extends StatelessWidget {
  final String username;
  final String email;

  const FriendCard({
    required this.username,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorConstants.primaryColor,
          width: 0.7,
        ),
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Avatar(
                firstName: "Antoni",
                lastName: 'Krawczyk',
                size: 60,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Email: $email',
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
  }
}
