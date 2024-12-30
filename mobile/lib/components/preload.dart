import 'package:flutter/material.dart';
import 'package:split_buddy/components/login.dart';
import 'package:split_buddy/components/register.dart';
import 'package:split_buddy/services/navigatorService.dart';

class Preload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Welcome to Split Buddy',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Colors.green[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo lub symbol aplikacji
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green[800],
                  border: Border.all(color: Colors.amber[600]!, width: 3),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.amber[700],
                  size: 60,
                ),
              ),
              SizedBox(height: 30),
              // Tytuł aplikacji
              Text(
                'SPLIT BUDDY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[600],
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 40),
              // Przyciski
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.amber[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.amber[700]!, width: 2),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.amber[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.amber[700]!, width: 2),
                    ),
                  ),
                  onPressed: () => NavigatorService.navigateTo(context, Register()),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Dodatkowy opis
              Text(
                'Manage your expenses effortlessly!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.amber[500],
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


