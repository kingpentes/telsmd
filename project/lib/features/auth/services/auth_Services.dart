import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account_model.dart';

class ApiConstants {
  static const String baseUrl = 'http://';
  static const String loginUrl = '$baseUrl/login';
  static const String logoutUrl = '$baseUrl/logout';
}

class authServices {
    Future<AccountModel> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      
      if (response.statusCode == 200) {
        return AccountModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
       throw Exception('Error: $e');
    }
  }

    Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.logoutUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      
      if (response.statusCode == 200) {
          return true;
      }
      return false;
    } catch (e) {
      return false;
    }
}
}