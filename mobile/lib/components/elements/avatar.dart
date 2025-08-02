import 'package:flutter/material.dart';

import '../../../constants/color-constants.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String firstName;
  final String lastName;

  const Avatar({
    Key? key,
    required this.firstName,
    required this.lastName,
    this.size = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initials = '${firstName[0]}${lastName[0]}'.toUpperCase();

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: ColorConstants.primaryColor,
      child: Text(
        initials,
        style: TextStyle(
          color: ColorConstants.blackColor,
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
