import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:split_buddy/components/preload/preload.dart';
import 'package:split_buddy/constants/color-constants.dart';
import 'package:split_buddy/enums/HttpResponses.dart';
import 'package:split_buddy/services/httpService.dart';
import 'package:split_buddy/services/navigatorService.dart';
import '../elements/custom-form-input.dart';
import '../login/login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final String? apiUrl = dotenv.env['API_URL'];
  final HttpService httpService = HttpService();

  String? validationMessage;

  void handleRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var response = await submit();
      var result = response?.body;
      if(result == null)return;
      if (result == HttpResponses.success.message) {
        NavigatorService.navigateTo(context, Login());
      } else {
        setState(() {
          validationMessage = result;
        });
      }
    }
  }

  Future<http.Response?> submit() async {
    var body = {
      'username': usernameController.text,
      'password': passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "email": emailController.text
    };
    var response = await httpService.post("/api/User/register", body);
    return response;
  }

  void goToLogin(context) {
    NavigatorService.navigateTo(context, Login());
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
                    'Register Account',
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
                if (validationMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      validationMessage!,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormInput(
                        controller: usernameController,
                        labelText: 'Username',
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
                        controller: emailController,
                        labelText: 'Email',
                        icon: Icons.mail_outlined,
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
                      CustomFormInput(
                        controller: passwordController,
                        labelText: 'Password',
                        obscureText: true,
                        suffixIcon: Icons.visibility,
                        onSuffixIconPressed: () {},
                      ),
                      SizedBox(height: 10),
                      CustomFormInput(
                        controller: confirmPasswordController,
                        labelText: 'Confirm password',
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
                                onPressed: () => handleRegister(context),
                                child: Text('Register account'),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          GestureDetector(
                            onTap: () => goToLogin(context), // 🔹 Przekierowanie po kliknięciu
                            child: Text.rich(
                              TextSpan(
                                text: "Do you have account?  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.whiteColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.primaryColor, // 🔹 Kolor dla "Sign Up"
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorConstants.primaryColor,
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
