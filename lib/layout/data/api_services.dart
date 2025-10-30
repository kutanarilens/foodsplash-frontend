import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  static String? token; // Menyimpan token untuk digunakan pada request selanjutnya

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        // Hanya perlu Content-Type untuk POST data login
        "Content-Type": "application/json", 
        // Header Authorization dihapus karena belum memiliki token saat login
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>; 
      if (data.containsKey("token")) {
         token = data["token"]; 
      }
      
      // 4. Mengembalikan seluruh data respons (termasuk "user" dan "message")
      // Menghubungkan dengan objek JSON: "status", "message", "user", "token"
      return data;
    } else {
      // Menangani kasus login gagal (misalnya, status code 401 atau 400)
      throw Exception("Failed to Login. Status: ${response.statusCode}");
    }
  }
}