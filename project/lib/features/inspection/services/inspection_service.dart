// Service untuk mengelola operasi pemeriksaan (cek potensial).
// Menangani pengiriman data ke server dan penyimpanan offline (backlog).
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project/core/constants/api_constants.dart';
import 'package:project/core/utils/token_storage.dart';
import 'package:project/core/database/db_helper.dart';
import '../models/inspection_model.dart';
import '../../users/models/customer_model.dart';

class InspectionService {
  final http.Client client;
  final DbHelper dbHelper = DbHelper();

  InspectionService({http.Client? client}) : client = client ?? http.Client();

  // Mengirim data pemeriksaan ke server.
  Future<bool> submitInspection(InspectionModel data) async {
    try {
      // Get userId dari TokenStorage
      final userId = await TokenStorage.getUserId();
      if (userId == null) {
        print('Error: userId not found - user may not be logged in');
        return false;
      }

      final token = await TokenStorage.getToken();
      if (token == null) {
        print('Error: token not found - user may not be logged in');
        return false;
      }

      // Menggunakan MultipartRequest untuk mengirim file
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.cekpotUrl));
      
      // Header
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      // Data text fields
      final jsonData = await data.toJsonForMultipart(userId: userId);
      jsonData.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Tambahkan file gambar
      final doc = data.documentation;
      await _addFileToRequest(request, 'img_satu', doc.fotoKwh);
      await _addFileToRequest(request, 'img_dua', doc.fotoRelay);
      await _addFileToRequest(request, 'img_tiga', doc.fotoKubikel);
      await _addFileToRequest(request, 'img_empat', doc.fotoHasil1);
      await _addFileToRequest(request, 'img_lima', doc.fotoHasil2);
      await _addFileToRequest(request, 'doc_ba', doc.beritaAcara);

      // Kirim request
      final streamedResponse = await request.send().timeout(const Duration(seconds: 60));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data berhasil dikirim ke server');
        return true;
      } else {
        print(
          'Gagal mengirim pemeriksaan: ${response.statusCode} - ${response.body}',
        );
        // Jika error server, simpan ke backlog
        if (response.statusCode >= 500) {
          await _saveToBacklog(data, userId);
          return true;
        }
        return false;
      }
    } on SocketException {
      // Tidak ada koneksi internet, simpan ke backlog
      final userId = await TokenStorage.getUserId();
      if (userId != null) {
        await _saveToBacklog(data, userId);
      }
      return true;
    } catch (e) {
      print('Exception saat mengirim pemeriksaan: $e');
      // Simpan ke backlog kecuali error format data
      if (e is! FormatException) {
        final userId = await TokenStorage.getUserId();
        if (userId != null) {
          await _saveToBacklog(data, userId);
        }
        return true;
      }
      return false;
    }
  }

  // Helper untuk menambahkan file ke MultipartRequest
  Future<void> _addFileToRequest(http.MultipartRequest request, String fieldName, String filePath) async {
    if (filePath.isNotEmpty) {
      final file = File(filePath);
      if (await file.exists()) {
        request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      }
    }
  }

  // Menyimpan data pemeriksaan ke database lokal (backlog) untuk dikirim nanti.
  Future<void> _saveToBacklog(InspectionModel data, int userId) async {
    try {
      await dbHelper.insertInspection(data, userId: userId);
      print('Data berhasil disimpan ke backlog (database offline).');
    } catch (e) {
      print('Gagal menyimpan ke backlog: $e');
    }
  }

  // Mengirim ulang semua data backlog yang belum tersinkronisasi ke server.
  Future<void> syncBacklog() async {
    try {
      final maps = await dbHelper.getUnsyncedInspectionsMaps();
      if (maps.isEmpty) {
        print('Tidak ada item backlog untuk disinkronkan.');
        return;
      }

      print(
        'Ditemukan ${maps.length} item di backlog. Memulai sinkronisasi...',
      );

      final token = await TokenStorage.getToken();
      if (token == null) {
        print('Tidak dapat sinkronisasi: token tidak ditemukan');
        return;
      }

      for (var map in maps) {
        final localId = map['local_id'];
        final userId = map['user_id'] as int?;

        if (userId == null) {
          print('Skipping item $localId: userId tidak ditemukan');
          continue;
        }

        try {
          final model = InspectionModel.fromJson(map);
          var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.cekpotUrl));
          request.headers['Accept'] = 'application/json';
          request.headers['Authorization'] = 'Bearer $token';

          // Data text fields
          final jsonData = await model.toJsonForMultipart(userId: userId);
          jsonData.forEach((key, value) {
            if (value != null) {
              request.fields[key] = value.toString();
            }
          });

          // Coba tambahkan file gambar jika masih ada
          final doc = model.documentation;
          await _addFileToRequest(request, 'img_satu', doc.fotoKwh);
          await _addFileToRequest(request, 'img_dua', doc.fotoRelay);
          await _addFileToRequest(request, 'img_tiga', doc.fotoKubikel);
          await _addFileToRequest(request, 'img_empat', doc.fotoHasil1);
          await _addFileToRequest(request, 'img_lima', doc.fotoHasil2);
          await _addFileToRequest(request, 'doc_ba', doc.beritaAcara);

          final streamedResponse = await request.send().timeout(const Duration(seconds: 60));
          final response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200 || response.statusCode == 201) {
            print('Item dengan ID Lokal: $localId berhasil disinkronkan');
            await dbHelper.deleteInspection(localId);
          } else {
            if (response.statusCode < 500) {
              print('Gagal sinkronisasi item $localId: ${response.statusCode}');
            }
          }
        } catch (e) {
          print('Error saat sinkronisasi item $localId: $e');
        }
      }
    } catch (e) {
      print('Exception saat sinkronisasi backlog: $e');
    }
  }

  // Mengambil data pemeriksaan berdasarkan ID dari server.
  Future<InspectionModel?> getInspection(String id) async {
    try {
      final token = await TokenStorage.getToken();
      final response = await client.get(
        Uri.parse('${ApiConstants.cekpotUrl}/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return InspectionModel.fromJson(json);
      } else {
        print('Gagal mengambil data pemeriksaan: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception saat mengambil data pemeriksaan: $e');
      return null;
    }
  }

  // Mengambil semua data pemeriksaan dari server.
  Future<List<InspectionModel>> getAllInspections() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await client.get(
        Uri.parse(ApiConstants.cekpotUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => InspectionModel.fromJson(json)).toList();
      } else {
        print('Gagal mengambil daftar pemeriksaan: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception saat mengambil daftar pemeriksaan: $e');
      return [];
    }
  }

  // Mengambil informasi pelanggan berdasarkan ID Pelanggan.
  Future<CustomerModel?> getCustomerInfoById(String id) async {
    try {
      final token = await TokenStorage.getToken();

      print('Token: $token');
      print('URL: ${ApiConstants.dilUrl}/$id');

      final response = await client.get(
        Uri.parse('${ApiConstants.dilUrl}/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Response status DIL: ${response.statusCode}');
      print('Response body DIL: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);

        // Menangani berbagai format response (array atau object)
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          return CustomerModel.fromJson(jsonResponse[0]);
        } else if (jsonResponse is Map<String, dynamic>) {
          // Cek apakah data ada di dalam key 'data'
          if (jsonResponse.containsKey('data')) {
            final data = jsonResponse['data'];
            if (data is List && data.isNotEmpty) {
              return CustomerModel.fromJson(data[0]);
            } else if (data is Map<String, dynamic>) {
              return CustomerModel.fromJson(data);
            }
          }
          return CustomerModel.fromJson(jsonResponse);
        }
        return null;
      } else {
        print('Gagal mengambil info pelanggan: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception saat mengambil info pelanggan: $e');
      return null;
    }
  }
}
