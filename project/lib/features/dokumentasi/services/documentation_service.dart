import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/documentation_model.dart';

class DocumentationService {
  Future<DocumentationModel> inputDocumentation(DocumentationModel documentation) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(documentation.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DocumentationModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input documentation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting documentation: $e');
    }
  }

  Future<List<DocumentationModel>> getDocumentation() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.cekpotUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => DocumentationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load documentation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching documentation: $e');
    }
  }
}