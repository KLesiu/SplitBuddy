import 'package:flutter/material.dart';
import 'add_friend_widget.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Map<String, String>> _friends = [];

  void _addFriend(String name, String email) {
    setState(() {
      _friends.add({'name': name, 'email': email});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Friends'),
      ),
      body: Column(
        children: [
          AddFriendWidget(
            onFriendAdded: _addFriend,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _friends.isEmpty
                  ? Center(
                child: Text(
                  'No friends added yet.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
                  : ListView.builder(
                itemCount: _friends.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF4EA95F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFC4A663),
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      title: Text(
                        _friends[index]['name']!,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Email: ${_friends[index]['email']}',
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
// import 'add_friend_widget.dart';
//
// class FriendsPage extends StatefulWidget {
//   const FriendsPage({Key? key}) : super(key: key);
//
//   @override
//   _FriendsPageState createState() => _FriendsPageState();
// }
//
// class _FriendsPageState extends State<FriendsPage> {
//   List<String> _friends = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4EA95F),
//         title: Text('Friends'),
//       ),
//       body: Column(
//         children: [
//           AddFriendWidget(
//
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _friends.isEmpty
//                   ? Center(
//                 child: Text(
//                   'No friends added yet.',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               )
//                   : ListView.builder(
//                 itemCount: _friends.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Color(0xFF4EA95F),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Color(0xFFC4A663),
//                         child: Icon(Icons.person, color: Colors.black),
//                       ),
//                       title: Text(
//                         _friends[index],
//                         style: TextStyle(fontSize: 16, color: Colors.black),
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
