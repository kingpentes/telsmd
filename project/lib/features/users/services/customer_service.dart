import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/customer_model.dart';

class CustomerService {
  // Get all customers
  Future<List<CustomerModel>> getCustomers() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.cekpotUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CustomerModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching customers: $e');
    }
  }

  // Get customer by ID
  Future<CustomerModel> getCustomerById(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.cekpotUrl}/$id'));

      if (response.statusCode == 200) {
        return CustomerModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching customer: $e');
    }
  }

  // Input Info Pelanggan
  Future<CustomerModel> inputInfoPelanggan(CustomerModel customer) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CustomerModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to input customer info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error inputting customer info: $e');
    }
  }
}
