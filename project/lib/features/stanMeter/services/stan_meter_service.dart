import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/stan_meter_model.dart';

class StanMeterService {
  Future<List<StanMeterModel>> getStanMeters() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.cekpotUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => StanMeterModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load stan meters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching stan meters: $e');
    }
  }

  // Get stan meter by ID
  Future<StanMeterModel> getStanMeterById(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.cekpotUrl}/$id'));

      if (response.statusCode == 200) {
        return StanMeterModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load stan meter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching stan meter: $e');
    }
  }

  // Input Stan Meter
  Future<StanMeterModel> inputStanMeter(StanMeterModel stanMeter) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(stanMeter.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return StanMeterModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input stan meter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting stan meter: $e');
    }
  }
}