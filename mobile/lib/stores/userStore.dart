import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String token;

  User({required this.username, required this.token});

  Map<String, dynamic> toJson() => {
    'username': username,
    'token': token,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      token: json['token'],
    );
  }
  @override
  String toString() {
    return '{username: $username, token: $token}';
  }
}

class UserStore {
  static const String _userKey = "USER_KEY";

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
