import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  final Function(String) onFriendAdded;

  const FriendsPage({Key? key, required this.onFriendAdded}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<String> _friends = [];

  void _addFriend() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _controller = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Add Friend', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter friend name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    _friends.add(_controller.text);
                    widget.onFriendAdded(_controller.text);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
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
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Friends'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt_1, size: 32, color: Color(0xFFC4A663)),
            onPressed: _addFriend,
          ),
        ],
      ),
      body: Padding(
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
                  _friends[index],
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
