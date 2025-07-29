import 'package:flutter/material.dart';
import '../../../constants/color-constants.dart';


class Avatar extends StatelessWidget {
  final double size;

  const Avatar({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    final String firstName = 'Norbert';
    final String lastName = 'Gierczak';
    final String initials = '${firstName[0]}${lastName[0]}';

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

