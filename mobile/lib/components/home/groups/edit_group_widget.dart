import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_buddy/constants/color-constants.dart';

import '../../../services/httpService.dart';

class EditGroupWidget extends StatefulWidget {
  final String groupName;
  final int groupId;

  EditGroupWidget({Key? key, required this.groupName, required this.groupId})
      : super(key: key);

  @override
  _EditGroupWidgetState createState() => _EditGroupWidgetState();
}

class _EditGroupWidgetState extends State<EditGroupWidget> {
  List<Map<String, dynamic>> expenses = [];
  List<Map<String, dynamic>> groupMemberships = [];

  final HttpService httpService = HttpService();

  void addNewExpenseInGroup(context) {}

  Future<void> addNewMemberToGroup(String email, context) async {
    var body = {"userEmail": email, "groupId": widget.groupId};
    var response =
        await httpService.post("/api/GroupMembership/joinNewMember", body);
    if (response == null) return;
    var result = response.body;
    if (result == null) return;
    Navigator.of(context).pop();
    await getMemberships();
  }

  void showNewMemberDialog() {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Add to group',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'User Email',
                    border: OutlineInputBorder(),
                  ),
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
                addNewMemberToGroup(emailController.text, context);
              },
              child: Text('Add Friend'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getMemberships() async {
    var body = {"groupId": widget.groupId};
    var response = await httpService.post(
        "/api/GroupMembership/getGroupMemberships", body);
    if (response == null) return;
    var result = response.body;
    var item = jsonDecode(result);
    if (result == null) return;
    setState(() {
      groupMemberships = List<Map<String, dynamic>>.from(item);
    });
  }

  Future<void> getExpensesInsideGroup() async {
    var body = {"groupId": widget.groupId};
    var response =
        await httpService.post("/api/Payment/getPaymentsInsideGroup", body);
    if (response == null) return;
    var result = response.body;
    if (result == null) return;
    var item = jsonDecode(result);
    setState(() {
      expenses = List<Map<String, dynamic>>.from(item);
    });
  }

  @override
  void initState() {
    super.initState();
    // getExpensesInsideGroup();
    getMemberships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: Text(
          widget.groupName,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: ColorConstants.homeBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => addNewExpenseInGroup(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.secondaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Add New Expense'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => showNewMemberDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.secondaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Add New Member'),
                ),
              ],
            ),

            SizedBox(height: 16),
            Text(
              'Members',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            // Zamiast Expanded, użyj Flexible, jeśli chcesz, żeby zawartość miała elastyczny rozmiar
            Flexible(
              child: groupMemberships.isEmpty
                  ? Center(
                      child: Text(
                        'No memberships yet',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  : SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groupMemberships.length,
                        itemBuilder: (context, index) {
                          var member = groupMemberships[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: ColorConstants.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  member['user']['username'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(height: 16),
            Text(
              'Expenses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Zamiast Expanded, użyj Flexible w przypadku Expenses
            Flexible(
              child: expenses.isEmpty
                  ? Center(
                      child: Text(
                        'No expenses added yet.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        var expense = expenses[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              expense['description'],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${expense['amount'].toStringAsFixed(2)} ${expense['currency']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
