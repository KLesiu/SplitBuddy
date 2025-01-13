import 'package:flutter/material.dart';
import 'package:split_buddy/components/login/login.dart';
import 'package:split_buddy/components/register/register.dart';
import 'package:split_buddy/constants/color-constants.dart';
import 'package:split_buddy/services/navigatorService.dart';

class Preload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80),
              // Logo aplikacji
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.secondaryColor,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: ColorConstants.primaryColor,
                    size: 60,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Tytuł aplikacji
              Text(
                'SPLIT BUDDY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.whiteColor,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 40),
              // Przyciski logowania i rejestracji
              Column(
                children: [
                  SizedBox(
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
                      onPressed: () => NavigatorService.navigateTo(context, Login()),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
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
                      onPressed: () => NavigatorService.navigateTo(context, Register()),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Dodatkowy opis
              Text(
                'Manage your expenses effortlessly!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.whiteColor.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
