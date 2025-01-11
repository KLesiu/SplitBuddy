import 'package:flutter/material.dart';
import 'add_group_widget.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  List<Map<String, String>> _groups = [];

  void _addGroup(String groupName, String groupType) {
    setState(() {
      _groups.add({'name': groupName, 'type': groupType});
    });
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
            onGroupCreated: _addGroup,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _groups.isEmpty
                  ? Center(
                child: Text(
                  'No groups created yet.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
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
// import 'add_group_widget.dart'; // Import nowego widżetu
//
// class GroupsPage extends StatefulWidget {
//
//   const GroupsPage({Key? key}) : super(key: key);
//
//   @override
//   _GroupsPageState createState() => _GroupsPageState();
// }
//
// class _GroupsPageState extends State<GroupsPage> {
//   List<Map<String, String>> _groups = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4EA95F),
//         title: Text('Groups'),
//       ),
//       body: Column(
//         children: [
//           AddGroupWidget(
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _groups.isEmpty
//                   ? Center(
//                 child: Text(
//                   'No groups created yet.',
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//               )
//                   : ListView.builder(
//                 itemCount: _groups.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Color(0xFF4EA95F),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Color(0xFFC4A663),
//                         child: Icon(Icons.group, color: Colors.black),
//                       ),
//                       title: Text(
//                         _groups[index]['name']!,
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                       subtitle: Text(
//                         'Type: ${_groups[index]['type']}',
//                         style: TextStyle(fontSize: 14, color: Colors.black54),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
