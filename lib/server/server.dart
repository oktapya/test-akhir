import 'dart:convert';
import 'package:http/http.dart' as http;

class SiswaServer {
  // Alamat backend Next.js.
  // Untuk Android Emulator, gunakan 10.0.2.2
  static const String baseUrl = 'http://10.0.2.2:3000/api/siswa';

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Mengambil semua data siswa.
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

    if (hasil is List) {
      return hasil;
    }

    if (hasil is Map && hasil['data'] is List) {
      return List<dynamic>.from(hasil['data']);
    }

    throw Exception('Format respons API tidak sesuai.');
  }

  // Menambahkan siswa.
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

  // Mengedit siswa berdasarkan ID.
  static Future<void> editData(
      dynamic id,
      Map<String, dynamic> data,
      ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengedit siswa: ${response.statusCode}',
      );
    }
  }

  // Menghapus siswa berdasarkan ID.
  static Future<void> hapusData(dynamic id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
    );

    if (response.statusCode != 200 &&
        response.statusCode != 204) {
      throw Exception(
        'Gagal menghapus siswa: ${response.statusCode}',
      );
    }
  }
}