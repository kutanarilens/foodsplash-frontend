import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  static String?
      token;

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data.containsKey("token")) {
        token = data["token"];
      }

      return data;
    } else {
      throw Exception("Failed to Login. Status: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String confirmationPassword,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return data;
    } else if (response.statusCode == 422) {
      if (data.containsKey("errors")) {
        final errors = data["errors"] as Map<String, dynamic>;
        String firstError = errors.values.first[0];
        return {"status": "error", "message": firstError};
      }
      return {
        "status": "error",
        "message": data["message"] ?? "Validasi gagal.",
      };
    } else {
      return {
        "status": "error",
        "message": "Terjadi kesalahan server. Status: ${response.statusCode}",
      };
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {"status": "success", "message": "Logout berhasil"};
  }
}