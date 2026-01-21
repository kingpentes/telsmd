import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/ct_inspection_model.dart';

class CtInspectionService {
  Future<CtInspectionModel> inputCtInspection(CtInspectionModel ctInspection) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ctInspection.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CtInspectionModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input ct inspection: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting ct inspection: $e');
    }
  }