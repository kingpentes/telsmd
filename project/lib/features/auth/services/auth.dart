import '../models/users.dart';

class authServices {
    Future<usersModel> register(usersModel user) async {
        return user;
    }

    Future<usersModel> login(usersModel user) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      // Mengembalikan format error standar jika terjadi masalah koneksi.
      return {'status': 'error', 'message': 'Koneksi gagal: ${e.toString()}'};
    }
}