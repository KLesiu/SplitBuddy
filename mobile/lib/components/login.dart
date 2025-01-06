import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:split_buddy/components/register.dart';
import 'package:split_buddy/enums/HttpResponses.dart';
import 'package:split_buddy/services/httpService.dart';
import 'package:split_buddy/services/navigatorService.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String? apiUrl = dotenv.env['API_URL'];
  final HttpService httpService = HttpService();

  void handleLogin(BuildContext context) async{
    var response = await submit();
    var result = response.body;
    if(result != HttpResponses.unauthorized.message ) {
      NavigatorService.navigateTo(context, Home());
    }

  }
  Future<http.Response>submit()async{
    var body = {
      "username":usernameController.text,
      "password":passwordController.text
    };
    var response = await httpService.post("/api/User/login",body);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.green[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tytuł ekranu
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[600],
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),

                // Pole na nazwę użytkownika
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.amber[700]),
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
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
                SizedBox(height: 20),

                // Pole na hasło
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.amber[700]),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
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
                SizedBox(height: 30),

                // Przycisk logowania
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green[800],
                      foregroundColor: Colors.amber[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.amber[700]!, width: 2),
                      ),
                      elevation: 5, // Dodanie cienia przycisku
                    ),
                    onPressed: () => handleLogin(context),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Przycisk do rejestracji
                TextButton(
                  onPressed: () {
                    // Możesz dodać logikę dla przejścia do ekranu rejestracji
                    NavigatorService.navigateTo(context, Register());
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Colors.amber[700],
                      fontSize: 16,
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
// import 'home.dart';
//
// class Login extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void handleLogin(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       // Jeśli walidacja pól się powiedzie, przenosimy na ekran główny
//       NavigatorService.navigateTo(context, Home());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         title: Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)
//         ),
//         backgroundColor: Colors.green[900],
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
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green[600],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     labelStyle: TextStyle(color: Colors.amber[700]),
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.amber[700]!),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.amber[700]!),
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
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
//                     labelStyle: TextStyle(color: Colors.amber[700]),
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.amber[700]!),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.amber[700]!),
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green[800],
//                       foregroundColor: Colors.amber[700],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                         side: BorderSide(color: Colors.amber[700]!, width: 2),
//                       ),
//                     ),
//                     onPressed: () => handleLogin(context),
//                     child: Text('Login'),
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
//
//
//
//
//
//
//
//
//
//
//
//
