import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/kwh_meter_model.dart';

class KwhMeterService {
  Future<List<KwhMeterModel>> getKwhMeters() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.cekpotUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => KwhMeterModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load kwh meters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching kwh meters: $e');
    }
  }

  // Get kwh meter by ID
  Future<KwhMeterModel> getKwhMeterById(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.cekpotUrl}/$id'));

      if (response.statusCode == 200) {
        return KwhMeterModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load kwh meter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching kwh meter: $e');
    }
  }

  // Input Kwh Meter
  Future<KwhMeterModel> inputKwhMeter(KwhMeterModel kwhMeter) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(kwhMeter.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return KwhMeterModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input kwh meter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting kwh meter: $e');
    }
  }
}