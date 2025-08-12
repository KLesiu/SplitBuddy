import 'package:flutter/material.dart';

import '../../../constants/color-constants.dart';
import '../../../services/httpService.dart';
import '../../elements/custom-form-input.dart';

class AddFriendWidget extends StatelessWidget {
  final Function() onFriendAdded;
  final HttpService httpService = HttpService();

  AddFriendWidget({Key? key, required this.onFriendAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF4EA95F),
      onPressed: () {
        _showAddFriendDialog(context);
      },
      child: Icon(
        Icons.add_rounded,
        // zamiana z Icons.add na add_rounded dla grubszej ikony
        size:
            45, // zwiększenie rozmiaru, żeby plusik był większy i bardziej widoczny
        color: Colors.black,
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void addFriend() async {
      var body = {'email': emailController.text};
      var response = await httpService.post("/api/Friendship/addFriend", body);
      if (response == null) return;
      var result = response.body;
      if (result == null) return;
      Navigator.of(context).pop();
      onFriendAdded();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorConstants.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Add Friends',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: ColorConstants.whiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFormInput(
                  controller: emailController,
                  labelText: 'Friend Email',
                  icon: Icons.search,
                  fillColor: ColorConstants.homeBackgroundColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4EA95F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addFriend();
                }
              },
              child: const Text(
                'Add Friend',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
