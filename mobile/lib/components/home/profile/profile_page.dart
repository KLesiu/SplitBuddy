import 'package:flutter/material.dart';
import 'package:split_buddy/components//login/login.dart'; // Importujemy ekran logowania

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4EA95F),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 30, color: Colors.amber[700]),
            onPressed: () {
              // Akcja przycisku wylogowania - przekierowanie na ekran logowania
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Profile content here',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF4EA95F),
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Text(
//           'Profile content here',
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
