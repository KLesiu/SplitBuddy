import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements//avatar.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    // Tu pobierasz dane
    final String firstName = 'Norbert';
    final String lastName = 'Gierczak';

    return Avatar(
      firstName: firstName,
      lastName: lastName,
      size: 60,
    );
  }
}
