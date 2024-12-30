import 'package:flutter/material.dart';
import 'package:split_buddy/services/navigatorService.dart';
import 'home.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Jeśli walidacja pól się powiedzie, przenosimy na ekran główny
      NavigatorService.navigateTo(context, Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login Screen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[300],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.green[300]),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.green[300]),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[500]!),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () => handleLogin(context),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:split_buddy/services/navigatorService.dart';
// import 'home.dart';
//
// class Login extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void handleLogin(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final username = usernameController.text;
//       final password = passwordController.text;
//
//       NavigatorService.navigateTo(context, Home());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Login Screen',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a username';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters long';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.zero,
//                         ),
//                       ),
//                       onPressed: () => handleLogin(context),
//                       child: Text('Login'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }















