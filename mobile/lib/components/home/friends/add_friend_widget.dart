import 'package:flutter/material.dart';

import '../../../services/httpService.dart';

class AddFriendWidget extends StatelessWidget {
  final Function() onFriendAdded;
  final HttpService httpService = HttpService();


  AddFriendWidget({Key? key, required this.onFriendAdded}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showAddFriendDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4EA95F),
          foregroundColor: Colors.black,
        ),
        child: Text('Add New Friend'),
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void addFriend() async{
      var body ={
        'email':emailController.text
      };
      var response = await httpService.post("/api/Friendship/addFriend", body);
      if(response == null)return;
      var result = response.body;
      if(result == null)return;
      Navigator.of(context).pop();
      onFriendAdded();

    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Add New Friend', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Friend Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA95F),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                addFriend();
              },
              child: Text('Add Friend'),
            ),
          ],
        );
      },
    );
  }
}
