import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../stores/userStore.dart';

class HttpService {
  final String apiUrl = dotenv.env['API_URL'] ?? "";
  final UserStore userStore = UserStore();

  Future<String?> getToken() async {
    final user = await userStore.getUser();
    return user?.token;
  }

  Future<http.Response?> get(String endpoint) async {
    String? token = await getToken();
    return await http.get(
      Uri.parse(apiUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        if(token != null)'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response?> post(String endpoint, Object body) async {
    String? token = await getToken();
    return await http.post(
      Uri.parse(apiUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
