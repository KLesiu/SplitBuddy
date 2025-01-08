import 'package:flutter/material.dart';
import 'add_group_widget.dart'; // Import nowego widżetu

class GroupsPage extends StatefulWidget {
  final Function(String, String) onGroupCreated;

  const GroupsPage({Key? key, required this.onGroupCreated}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Map<String, String>> _groups = [];

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
            onGroupCreated: (groupName, groupType) {
              setState(() {
                _groups.add({'name': groupName, 'type': groupType});
                widget.onGroupCreated(groupName, groupType);
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _groups.isEmpty
                  ? Center(
                child: Text(
                  'No groups created yet.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
                  : ListView.builder(
                itemCount: _groups.length,
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
                        _groups[index]['name']!,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Type: ${_groups[index]['type']}',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
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





// import 'package:flutter/material.dart';
//
// class GroupsPage extends StatefulWidget {
//   final Function(String, String) onGroupCreated;
//
//   const GroupsPage({Key? key, required this.onGroupCreated}) : super(key: key);
//
//   @override
//   _GroupsPageState createState() => _GroupsPageState();
// }
//
// class _GroupsPageState extends State<GroupsPage> {
//   List<Map<String, String>> _groups = [];
//
//   void _createGroup() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController _nameController = TextEditingController();
//         TextEditingController _typeController = TextEditingController();
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: Text('Create Group', style: TextStyle(fontWeight: FontWeight.bold)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter group name',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 controller: _typeController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter group type',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF4EA95F),
//                 foregroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 if (_nameController.text.isNotEmpty && _typeController.text.isNotEmpty) {
//                   setState(() {
//                     _groups.add({
//                       'name': _nameController.text,
//                       'type': _typeController.text,
//                     });
//                     widget.onGroupCreated(_nameController.text, _typeController.text);
//                   });
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4EA95F),
//         title: Text('Groups'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_circle_outline, size: 30, color: Color(0xFFC4A663)),
//             onPressed: _createGroup,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: _groups.isEmpty
//             ? Center(
//           child: Text(
//             'No groups created yet.',
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         )
//             : ListView.builder(
//           itemCount: _groups.length,
//           itemBuilder: (context, index) {
//             return Card(
//               color: Color(0xFF4EA95F),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: Icon(Icons.group, color: Colors.black),
//                 title: Text(
//                   _groups[index]['name']!,
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//                 subtitle: Text(
//                   _groups[index]['type']!,
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
