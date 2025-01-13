import 'package:flutter/material.dart';
import '../../../services/httpService.dart';
import 'add_group_widget.dart';
import 'edit_group_widget.dart';
import 'dart:convert';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final HttpService httpService = HttpService();
  List<Map<String, dynamic>> groups = [];

  void getGroups() async {
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

  void _navigateToEditGroup(String groupName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditGroupWidget(groupName: groupName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Groups'),
      ),
      body: Column(
        children: [
          AddGroupWidget(
            onGroupCreated: getGroups,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: groups.isEmpty
                  ? Center(
                child: Text(
                  'No groups created yet.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
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
                        style:
                        TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onTap: () => _navigateToEditGroup(groups[index]['name']),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

