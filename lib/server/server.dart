
import 'dart:convert';
import 'package:http/http.dart' as http;

class SiswaServer {
  // Alamat Backend Next.js
  static const String baseUrl =
      'http://localhost:3000/api/siswa';

  static const String loginUrl =
      'http://localhost:3000/api/login';

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // POST: Login Admin
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final hasil = jsonDecode(response.body);

    if (response.statusCode == 200 && hasil['status'] == true) {
      return true;
    }

    if (response.statusCode == 401) {
      return false;
    }

    throw Exception(
      hasil['message'] ?? 'Gagal menghubungi server',
    );
  }

  // GET: Mengambil semua data siswa
  static Future<List<dynamic>> ambilData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil data siswa: ${response.statusCode}',
      );
    }

    final hasil = jsonDecode(response.body);

    if (hasil is Map &&
        hasil['status'] == true &&
        hasil['data'] is List) {
      return List<dynamic>.from(hasil['data']);
    }

    throw Exception('Format respons API tidak sesuai.');
  }

  // POST: Menambahkan data siswa
  static Future<void> tambahData(
      Map<String, dynamic> data,
      ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(
        'Gagal menambahkan siswa: ${response.statusCode}',
      );
    }
  }

  // PUT: Mengubah data siswa
  static Future<void> editData(
      dynamic id,
      Map<String, dynamic> data,
      ) async {
    final response = await http.put(
      Uri.parse('$baseUrl?id=$id'),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengedit siswa: ${response.statusCode}',
      );
    }
  }

  // DELETE: Menghapus data siswa
  static Future<void> hapusData(dynamic id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl?id=$id'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal menghapus siswa: ${response.statusCode}',
      );
    }
  }
}
