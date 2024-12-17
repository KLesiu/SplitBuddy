import 'package:flutter/material.dart';
import 'package:split_buddy/components/login.dart';
import 'package:split_buddy/components/register.dart';
import 'package:split_buddy/services/navigatorService.dart';

class Preload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose an option:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => NavigatorService.navigateTo(context, Login()),
                child: Text('Sign In'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => NavigatorService.navigateTo(context, Register()),
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:split_buddy/components/login.dart';
// import 'package:split_buddy/components/register.dart';
//
// class Preload extends StatelessWidget {
//   // Funkcja do nawigacji
//   void navigateTo(BuildContext context, Widget destination) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => destination),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Choose an option:',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => navigateTo(context, Login()),
//                 child: Text('Sign In'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () => navigateTo(context, Register()),
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









