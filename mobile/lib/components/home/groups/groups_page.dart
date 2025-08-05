import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import '../../../services/httpService.dart';
import 'edit_group_widget.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final HttpService httpService = HttpService();
  List<Map<String, dynamic>> groups = [];

  Future<void> getGroups() async {
    var response = await httpService.get("/api/Group/getAllUserGroups");
    if (response == null) return;
    var result = jsonDecode(response.body);
    if (result != null && result is List) {
      setState(() {
        groups = List<Map<String, dynamic>>.from(result as Iterable);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  void navigateToEditGroup(String groupName, int groupId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditGroupWidget(groupName: groupName, groupId: groupId),
      ),
    );
  }

  void showCreateGroupDialog() {
    final TextEditingController groupNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Create New Group',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextFormField(
            controller: groupNameController,
            decoration: InputDecoration(
              labelText: 'Group Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EA95F),
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                var body = {
                  "name": groupNameController.text,
                };
                var response =
                    await httpService.post("/api/Group/createGroup", body);
                if (response != null) {
                  Navigator.of(context).pop();
                  getGroups();
                }
              },
              child: Text('Create Group'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorConstants.primaryColor,
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Groups',
          style: TextStyle(
              color: ColorConstants.primaryColor), // Ustawienie koloru
        ),
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: groups.isEmpty
                    ? Center(
                        child: Text(
                          'No groups created yet.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color(0xFF4EA95F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFFC4A663),
                                child: Icon(Icons.group, color: Colors.black),
                              ),
                              title: Text(
                                groups[index]['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () => navigateToEditGroup(
                                  groups[index]['name'], groups[index]['id']),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.secondaryColor,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: showCreateGroupDialog,
      ),
    );
  }
}