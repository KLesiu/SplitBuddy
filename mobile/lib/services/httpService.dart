import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;




class HttpService{
  final String apiUrl = dotenv.env['API_URL'] ?? "";
  Future<http.Response>get(String endpoint ) async{
    return await http.get(Uri.parse(apiUrl+endpoint));
  }
  Future<http.Response>post(String endpoint, Object body) async{
    return await http.post(
      Uri.parse(apiUrl+endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }
}