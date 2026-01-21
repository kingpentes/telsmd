import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/core/constants/api_constants.dart';
import '../models/inspection_model.dart';

class InspectionService {
  final http.Client client;

  InspectionService({http.Client? client}) : client = client ?? http.Client();

  Future<bool> submitInspection(InspectionModel data) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.inspectionUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Log error or throw exception based on project standards
        print('Failed to submit inspection: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception submitting inspection: $e');
      return false;
    }
  }

  Future<InspectionModel?> getInspection(String id) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.inspectionUrl}/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return InspectionModel.fromJson(json);
      } else {
        print('Failed to get inspection: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception getting inspection: $e');
      return null;
    }
  }
}
