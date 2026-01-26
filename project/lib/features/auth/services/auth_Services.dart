import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/token_storage.dart';
import '../models/account_model.dart';

class AuthServices {
  Future<AccountModel> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final account = AccountModel.fromJson(jsonResponse);

        // Simpan token ke storage
        if (account.token != null) {
          await TokenStorage.saveToken(account.token!);
          await TokenStorage.saveUserInfo(
            id: account.id,
            username: account.username,
          );
        }

        return account;
      } else {
        throw Exception(
          'Login failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> logout() async {
    try {
      await TokenStorage.clearAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Mengambil token dari storage.
  Future<String?> getToken() async {
    return await TokenStorage.getToken();
  }
}
