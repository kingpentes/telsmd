import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/protection_model.dart';

class ProtectionService {
  Future<ProtectionModel> inputProtection(ProtectionModel protection) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(protection.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProtectionModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input protection: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting protection: $e');
    }
  }
}