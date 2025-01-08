import 'package:flutter/material.dart';

class AddGroupWidget extends StatefulWidget {
  const AddGroupWidget({Key? key}) : super(key: key);

  @override
  _AddGroupWidgetState createState() => _AddGroupWidgetState();
}

class _AddGroupWidgetState extends State<AddGroupWidget> {
  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _groupTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _groupNameController,
            decoration: InputDecoration(
              labelText: 'Group Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _groupTypeController,
            decoration: InputDecoration(
              labelText: 'Group Type',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4EA95F), // Zmieniono z 'primary'
              foregroundColor: Colors.black, // Zmieniono z 'onPrimary'
            ),
            child: Text('Create Group'),
          ),
        ],
      ),
    );
  }
}
