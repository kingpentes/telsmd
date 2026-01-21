import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/result_model.dart';

class ResultService {
  Future<ResultModel> inputResult(ResultModel result) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(result.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input result: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting result: $e');
    }
  }

  Future<List<ResultModel>> getResult() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.cekpotUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ResultModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load result: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching result: $e');
    }
  }
}