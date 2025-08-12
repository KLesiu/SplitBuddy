import 'package:flutter/material.dart';
import '../../../components/elements/avatar.dart';
import '../../../constants/color-constants.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String firstName;
  final String lastName;

  const Header({
    Key? key,
    required this.username,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome back, ',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                TextSpan(
                  text: username,
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Avatar(
            firstName: firstName,
            lastName: lastName,
            size: 40,
          ),
        ],
      ),
    );
  }
}