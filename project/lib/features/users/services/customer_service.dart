/// Service untuk mengambil data pelanggan dari API.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/customer_model.dart';
import '../../auth/services/auth_Services.dart';

class CustomerService {
  /// Mengambil daftar semua pelanggan dari server.
  /// Mengembalikan list kosong jika terjadi error.
  Future<List<CustomerModel>> getCustomers() async {
    try {
      final token = await AuthServices().getToken();
      if (token == null) throw Exception('Token tidak ditemukan');

      final response = await http.get(
        Uri.parse(ApiConstants.dilListUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        List<dynamic> list;
        // Menangani format response DataTables ({data: [...]}) atau array langsung
        if (data is Map && data.containsKey('data') && data['data'] is List) {
           list = data['data'];
        } else if (data is List) {
           list = data;
        } else {
           return [];
        }

        return list.map((e) => CustomerModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal memuat data pelanggan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil data pelanggan: $e');
    }
  }
}
