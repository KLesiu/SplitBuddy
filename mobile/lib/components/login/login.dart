import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:split_buddy/components/elements/custom-form-input.dart';
import 'package:split_buddy/components/register/register.dart';
import 'package:split_buddy/constants/color-constants.dart';
import 'package:split_buddy/enums/HttpResponses.dart';
import 'package:split_buddy/services/httpService.dart';
import 'package:split_buddy/services/navigatorService.dart';
import 'package:http/http.dart' as http;
import 'package:split_buddy/stores/userStore.dart';

import '../home/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String? apiUrl = dotenv.env['API_URL'];
  final HttpService httpService = HttpService();

  String? errorMessage;

  void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var response = await submit();
      var result = response?.body;
      if(result == null)return;
      if (result != HttpResponses.unauthorized.message) {
        setState(() {
          errorMessage = null;
        });
        var decoded = jsonDecode(result);
        var user = User(username: usernameController.text, token: decoded['token']);

        await UserStore().saveUser(user);
        NavigatorService.navigateTo(context, Home());
      } else {
        setState(() {
          errorMessage = result;
        });
      }
    }
  }

  Future<http.Response?> submit() async {
    var body = {
      "username": usernameController.text,
      "password": passwordController.text,
    };
    return await httpService.post("/api/User/login", body);
  }

  void goToRegister(context) {
    NavigatorService.navigateTo(context, Register());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 300),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormInput(
                        controller: usernameController,
                        labelText: "Username",
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomFormInput(
                        controller: passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        suffixIcon: Icons.visibility,
                        onSuffixIconPressed: () {},
                      ),
                      SizedBox(height: 32),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.secondaryColor,
                                  foregroundColor: ColorConstants.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => handleLogin(context),
                                child: Text('Login'),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryColor,
                                  foregroundColor: ColorConstants.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => goToRegister(context),
                                child: Text('Don\'t have an account? Sign Up'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
