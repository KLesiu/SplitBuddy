import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:split_buddy/components/elements/custom-form-input.dart';
import 'package:split_buddy/components/preload/preload.dart';
import 'package:split_buddy/components/register/register.dart';
import 'package:split_buddy/constants/color-constants.dart';
import 'package:split_buddy/enums/HttpResponses.dart';
import 'package:split_buddy/services/httpService.dart';
import 'package:split_buddy/services/navigatorService.dart';
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
  final HttpService httpService = HttpService();

  String? errorMessage;

  void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var response = await submit();
      var result = response?.body;
      if (result == null) return;
      if (result != HttpResponses.unauthorized.message) {
        setState(() {
          errorMessage = null;
        });
        var decoded = jsonDecode(result);
        var user =
            User(username: usernameController.text, token: decoded['token']);

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

  void goToPreload(context) {
    NavigatorService.navigateTo(context, Preload());
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
                SizedBox(height: 140),
                Center(
                  child: SvgPicture.asset(
                    'lib/assets/images/logo.svg',
                    width: 160,
                    height: 160,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the data below to help you monitor your daily expenses, set a budget, and track how much money you have left for a given period.',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.greyColor,
                    ),
                  ),
                ),
                SizedBox(height: 24),
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
                                  backgroundColor: ColorConstants.primaryColor,
                                  foregroundColor: ColorConstants.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => handleLogin(context),
                                child: Text('Login account'),
                              ),
                            ),
                          ),
                          SizedBox(height: 80),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.primaryColor,
                              foregroundColor: ColorConstants.blackColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => goToPreload(context),
                            child: Text('Back'),
                          ),
                          SizedBox(height: 35),
                          GestureDetector(
                            onTap: () => goToRegister(
                                context), // 🔹 Przekierowanie po kliknięciu
                            child: Text.rich(
                              TextSpan(
                                text: "Don't have account?  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.whiteColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants
                                          .primaryColor, // 🔹 Kolor dla "Sign Up"
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorConstants.primaryColor,
                                    ),
                                  ),
                                ],
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
