import 'package:flutter/material.dart';

class AddFriendWidget extends StatelessWidget {
  final Function(String, String) onFriendAdded;

  const AddFriendWidget({Key? key, required this.onFriendAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _showAddFriendDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4EA95F),
          foregroundColor: Colors.black,
        ),
        child: Text('Add New Friend'),
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Add New Friend', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Friend Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Friend Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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
                if (_formKey.currentState!.validate()) {
                  onFriendAdded(_nameController.text, _emailController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Friend'),
            ),
          ],
        );
      },
    );
  }
}




// import 'package:flutter/material.dart';
//
// class AddFriendWidget extends StatelessWidget {
//   final Function(String, String) onFriendAdded;
//
//   const AddFriendWidget({Key? key, required this.onFriendAdded}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ElevatedButton(
//         onPressed: () {
//           _showAddFriendDialog(context);
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF4EA95F),
//           foregroundColor: Colors.black,
//         ),
//         child: Text('Add New Friend'),
//       ),
//     );
//   }
//
//   void _showAddFriendDialog(BuildContext context) {
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _emailController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: Text('Add New Friend', style: TextStyle(fontWeight: FontWeight.bold)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Friend Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Friend Email',
//                   border: OutlineInputBorder(),
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
//               ),
//               onPressed: () {
//                 if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty) {
//                   onFriendAdded(_nameController.text, _emailController.text);
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: Text('Add Friend'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
//
