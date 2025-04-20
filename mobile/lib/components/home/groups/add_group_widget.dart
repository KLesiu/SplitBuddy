import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import '../../../services/httpService.dart';

class AddGroupWidget extends StatelessWidget {
  final Function() onGroupCreated;
  final HttpService httpService = HttpService();

  AddGroupWidget({Key? key, required this.onGroupCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showCreateGroupDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.secondaryColor,
          foregroundColor: Colors.black,
        ),
        child: Text('Create New Group'),
      ),
    );
  }

  void _showCreateGroupDialog(BuildContext context) {
    final TextEditingController groupNameController = TextEditingController();

    void createGroup(context) async {
      var body = {
        "name": groupNameController.text,
      };
      var response = await httpService.post("/api/Group/createGroup", body);
      var result = response?.body;
      if (result == null) return;
      Navigator.of(context).pop();
      onGroupCreated();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Create New Group',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
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
              onPressed: () => createGroup(context),
              child: Text('Create Group'),
            ),
          ],
        );
      },
    );
  }
}
