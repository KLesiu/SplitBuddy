import 'package:flutter/material.dart';
import 'package:split_buddy/services/navigatorService.dart';
import 'login.dart';

class Register extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void handleRegister(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      NavigatorService.navigateTo(context, Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign up'),
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
                  'Register Screen',
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
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
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () => handleRegister(context),
                      child: Text('Sign Up'),
                    ),
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
// import 'login.dart';
//
// class Register extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   // Funkcja obsługująca logikę rejestracji
//   void handleRegister(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final username = usernameController.text;
//       final email = emailController.text;
//       final password = passwordController.text;
//
//       // Po poprawnej walidacji przenosimy na ekran logowania
//       NavigatorService.navigateTo(context, Login());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign up'),
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
//                   'Register Screen',
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
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return 'Please enter a valid email address';
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
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: confirmPasswordController,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     if (value != passwordController.text) {
//                       return 'Passwords do not match';
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
//                       onPressed: () => handleRegister(context),
//                       child: Text('Sign Up'),
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
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:split_buddy/services/navigatorService.dart';
// // import 'login.dart';
// //
// // class Register extends StatelessWidget {
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //
// //   final TextEditingController usernameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController confirmPasswordController = TextEditingController();
// //
// //   // Funkcja obsługująca logikę rejestracji
// //   void handleRegister(BuildContext context) {
// //     if (_formKey.currentState!.validate()) {
// //       final username = usernameController.text;
// //       final email = emailController.text;
// //       final password = passwordController.text;
// //
// //       // Po poprawnej walidacji przenosimy na ekran logowania
// //       NavigatorService.navigateTo(context, Login());
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Sign up'),
// //       ),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Register Screen',
// //                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                 ),
// //                 SizedBox(height: 20),
// //                 TextFormField(
// //                   controller: usernameController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Username',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a username';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 10),
// //                 TextFormField(
// //                   controller: emailController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Email',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   keyboardType: TextInputType.emailAddress,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter an email';
// //                     }
// //                     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// //                       return 'Please enter a valid email address';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 10),
// //                 TextFormField(
// //                   controller: passwordController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Password',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   obscureText: true,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a password';
// //                     }
// //                     if (value.length < 6) {
// //                       return 'Password must be at least 6 characters long';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 10),
// //                 TextFormField(
// //                   controller: confirmPasswordController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Confirm Password',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   obscureText: true,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please confirm your password';
// //                     }
// //                     if (value != passwordController.text) {
// //                       return 'Passwords do not match';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 Center(
// //                   child: ElevatedButton(
// //                     onPressed: () => handleRegister(context),
// //                     child: Text('Sign Up'),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// //
