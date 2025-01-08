import 'package:flutter/material.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> _friends = [];
  List<Map<String, String>> _groups = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  void _createGroup() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _nameController = TextEditingController();
        TextEditingController _typeController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Create Group', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter group name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(
                  hintText: 'Enter group type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_nameController.text.isNotEmpty && _typeController.text.isNotEmpty) {
                    _groups.add({
                      'name': _nameController.text,
                      'type': _typeController.text
                    });
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _pages() {
    return [
      // Zakładka Groups
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4EA95F),
          title: Text('Groups'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_circle_outline, size: 30, color: Color(0xFFC4A663)),
              onPressed: _createGroup,
            ),
            IconButton(
              icon: Icon(Icons.logout, size: 30, color: Color(0xFFC4A663)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
        body: Padding(
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
                  leading: Icon(Icons.group, color: Colors.black),
                  title: Text(
                    _groups[index]['name']!,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  subtitle: Text(
                    _groups[index]['type']!,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      // Zakładka Friends
      Scaffold(
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
      ),

      // Zakładka Add
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4EA95F),
          title: Text('Add'),
        ),
        body: Center(
          child: Icon(Icons.add_circle_outline, size: 100, color: Color(0xFFC4A663)),
        ),
      ),

      // Zakładka Notifications
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4EA95F),
          title: Text('Notifications'),
        ),
        body: Center(
          child: Text(
            'Notifications content here',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),

      // Zakładka Profile
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4EA95F),
          title: Text('Profile'),
        ),
        body: Center(
          child: Text(
            'Profile content here',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages()[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF4EA95F),
        selectedItemColor: Color(0xFFC4A663),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 28,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Color(0xFFBC9D5A),
              ),
              child: Icon(Icons.add, color: Colors.black, size: 32),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
