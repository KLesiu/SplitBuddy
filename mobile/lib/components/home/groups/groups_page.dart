import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';
import 'package:split_buddy/services/httpService.dart';

import '../../elements/custom-form-input.dart';
import '../../elements/group_card.dart';
import 'edit_group_widget.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final HttpService httpService = HttpService();
  List<Map<String, dynamic>> groups = [];
  List<Map<String, dynamic>> filteredGroups = [];
  final TextEditingController searchController = TextEditingController();

  Future<void> getGroups() async {
    var response = await httpService.get("/api/Group/getAllUserGroups");
    if (response == null) return;
    var result = jsonDecode(response.body);
    if (result != null && result is List) {
      setState(() {
        groups = List<Map<String, dynamic>>.from(result);
        filteredGroups = groups;
      });
    }
  }

  void filterGroups(String query) {
    setState(() {
      filteredGroups = groups
          .where((group) => group['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
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
  void initState() {
    super.initState();
    getGroups();
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
          'My groups',
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Column(
          children: [
            if (groups.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomFormInput(
                  controller: searchController,
                  labelText: 'Search...',
                  icon: Icons.search,
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: filteredGroups.isEmpty
                    ? Center(
                        child: Text(
                          'No groups found.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredGroups.length,
                        itemBuilder: (context, index) {
                          final group = filteredGroups[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: GestureDetector(
                              onTap: () => navigateToEditGroup(
                                  group['name'], group['id']),
                              child: GroupCard(
                                groupName: groups[index]['name'],
                                dateFrom:
                                    '28.08', // To oczywiście trzeba pobrać z API jeśli jest
                                dateTo: '10.09.2025',
                                membersCount:
                                    5, // też dynamicznie jeśli masz w danych
                                balanceInfo:
                                    '💵 You are owed PLN  23.00', // lub 'You are owed \$15.00'
                                onTap: () => navigateToEditGroup(
                                    groups[index]['name'], groups[index]['id']),
                              ),
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
