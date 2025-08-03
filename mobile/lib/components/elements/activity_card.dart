import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import 'avatar.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String subtitle;

  const ActivityCard(
      {required this.title,
      required this.description,
      required this.subtitle,
      Key? key})
      : super(key: key);

  final String firstName = 'Norbert';
  final String lastName = 'Gierczak';

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
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Avatar(
                firstName: firstName,
                lastName: lastName,
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
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    Text(
                      subtitle,
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
