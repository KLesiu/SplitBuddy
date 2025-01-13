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
  final HttpService httpService = HttpService();


  void addNewExpenseInGroup(context){

  }

  Future<void> getMemberships() async{
    var body = {
      "groupId":widget.groupId
    };
    var response = await httpService.post("/api/GroupMembership/getGroupMemberships",body);
    if(response == null)return;
    var result = response.body;
    print(result);
    if(result == null)return;

  }

  Future<void> getExpensesInsideGroup() async{
    var body = {
      "groupId":widget.groupId
    };
    var response = await httpService.post("/api/Payment/getPaymentsInsideGroup",body);
    if(response == null)return;
    var result = response.body;
    if(result == null)return;
    setState(() {
      expenses = List<Map<String, dynamic>>.from(result as Iterable);
    });  }


  @override
  void initState() {
    super.initState();
    getExpensesInsideGroup();
    getMemberships();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: Text(widget.groupName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed:()=>addNewExpenseInGroup(context) ,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.secondaryColor,
                foregroundColor: Colors.black,
              ),
              child: Text('Add New Expense'),
            ),
            SizedBox(height: 16),
            Text(
              'Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: expenses.isEmpty
                  ? Center(
                child: Text(
                  'No expenses added yet.',
                  style: TextStyle(fontSize: 16),
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
                      title: Text(expense['description']),
                      subtitle: Text(
                          '${expense['amount'].toStringAsFixed(2)} ${expense['currency']}'),
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

