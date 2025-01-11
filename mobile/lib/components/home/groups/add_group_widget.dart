import 'package:flutter/material.dart';

class AddGroupWidget extends StatelessWidget {
  final Function(String, String) onGroupCreated;

  const AddGroupWidget({Key? key, required this.onGroupCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showCreateGroupDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4EA95F),
          foregroundColor: Colors.black,
        ),
        child: Text('Create New Group'),
      ),
    );
  }

  void _showCreateGroupDialog(BuildContext context) {
    final TextEditingController _groupNameController = TextEditingController();
    final TextEditingController _groupTypeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Create New Group', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
              onPressed: () {
                if (_groupNameController.text.isNotEmpty &&
                    _groupTypeController.text.isNotEmpty) {
                  onGroupCreated(
                    _groupNameController.text,
                    _groupTypeController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text('Create Group'),
            ),
          ],
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
//
// class AddGroupWidget extends StatefulWidget {
//   const AddGroupWidget({Key? key}) : super(key: key);
//
//   @override
//   _AddGroupWidgetState createState() => _AddGroupWidgetState();
// }
//
// class _AddGroupWidgetState extends State<AddGroupWidget> {
//   TextEditingController _groupNameController = TextEditingController();
//   TextEditingController _groupTypeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: _groupNameController,
//             decoration: InputDecoration(
//               labelText: 'Group Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 12),
//           TextField(
//             controller: _groupTypeController,
//             decoration: InputDecoration(
//               labelText: 'Group Type',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: () {
//
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF4EA95F), // Zmieniono z 'primary'
//               foregroundColor: Colors.black, // Zmieniono z 'onPrimary'
//             ),
//             child: Text('Create Group'),
//           ),
//         ],
//       ),
//     );
//   }
// }
