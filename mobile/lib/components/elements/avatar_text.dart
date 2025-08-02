import 'package:flutter/material.dart';

import 'avatar.dart';

class AvatarText extends StatelessWidget {
  final double size;
  final String firstName;
  final String lastName;

  const AvatarText({
    super.key,
    required this.firstName,
    required this.lastName,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    final String initial =
        firstName.isNotEmpty ? firstName[0].toUpperCase() : '?';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar(
          firstName: firstName,
          lastName: lastName,
          size: size,
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: size,
          child: Text(
            '$initial. $lastName',
            style: TextStyle(
              fontSize: size * 0.15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
