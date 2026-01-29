/// Service untuk mengambil data pelanggan dari API.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/customer_model.dart';
import '../../auth/services/auth_Services.dart';

class CustomerPaginatedResponse {
  final List<CustomerModel> data;
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;

  CustomerPaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
  });
}

int _parseInt(dynamic value, int defaultValue) {
  if (value == null) return defaultValue;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}

class CustomerService {
  Future<CustomerPaginatedResponse> getCustomers({
    int page = 1,
    int perPage = 10,
    String? search,
  }) async {
    try {
      final token = await AuthServices().getToken();
      if (token == null) throw Exception('Token tidak ditemukan');

      final queryParams = {
        'page': page.toString(),
        'per_page': perPage.toString(),
      };
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final uri = Uri.parse(ApiConstants.dilListUrl).replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<dynamic> list;
        int currentPage = page;
        int lastPage = 1;
        int total = 0;
        int responsePerPage = perPage;

        // Handle Laravel pagination response
        if (data is Map) {
          if (data.containsKey('data') && data['data'] is List) {
            list = data['data'];
          } else {
            list = [];
          }
          currentPage = _parseInt(data['current_page'], page);
          lastPage = _parseInt(data['last_page'], 1);
          total = _parseInt(data['total'], list.length);
          responsePerPage = _parseInt(data['per_page'], perPage);
        } else if (data is List) {
          list = data;
          total = list.length;
        } else {
          list = [];
        }

        return CustomerPaginatedResponse(
          data: list.map((e) => CustomerModel.fromJson(e)).toList(),
          currentPage: currentPage,
          lastPage: lastPage,
          total: total,
          perPage: responsePerPage,
        );
      } else {
        throw Exception('Gagal memuat data pelanggan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil data pelanggan: $e');
    }
  }
}
