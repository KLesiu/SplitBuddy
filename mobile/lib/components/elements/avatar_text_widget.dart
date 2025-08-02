import 'package:flutter/material.dart';

import 'avatar_text.dart';

class AvatarTextWidget extends StatelessWidget {
  const AvatarTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Tu docelowo np. provider/bloc, a teraz tymczasowo mock:
    final String firstName = 'Norbert';
    final String lastName = 'Gierczak';

    return AvatarText(
      firstName: firstName,
      lastName: lastName,
    );
  }
}
