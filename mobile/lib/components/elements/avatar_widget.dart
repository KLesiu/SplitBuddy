import 'package:flutter/material.dart';
import 'package:split_buddy/components/elements//avatar.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

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
