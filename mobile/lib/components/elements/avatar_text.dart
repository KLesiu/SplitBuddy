import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements/avatar.dart';
 // importujemy nasz komponent

class AvatarText extends StatelessWidget {
  final double size;

  const AvatarText({super.key, this.size = 60});

  Map<String, String> getUserData() {
    return {
      'firstName': 'Norbert',
      'lastName': 'Iger',
    };
  }

  @override
  Widget build(BuildContext context) {
    final userData = getUserData();
    final String firstName = userData['firstName'] ?? '';
    final String lastName = userData['lastName'] ?? '';
    final String initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '?';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar(size: size),
        const SizedBox(height: 6),
        SizedBox(
          width: size, // szerokość równa avatarowi
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
