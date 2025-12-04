import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import ini diperlukan untuk DateFormat

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  
  // Data pengguna statis
  static String? username;
  static String? userEmail;
  static String? token;
  static String? userPhone;
  static String? userBio;
  static String? userGender;
  static DateTime? userBirthDate; // Menyimpan tanggal lahir sebagai objek DateTime

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      
      // Update data statis setelah login berhasil
      username = data['name'];
      userEmail = data["email"];
      token = data["token"];
      // Catatan: Anda mungkin perlu menambahkan pengambilan data profil lengkap di sini
      // Misalnya: userPhone = data["phone"]; dsb.

      return data;
    } else {
      // Perbaiki error handling untuk login
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return {
        "status": "error",
        "message": data["message"] ?? "Login gagal. Status: ${response.statusCode}",
      };
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
    // Bersihkan data statis saat logout
    username = null;
    userEmail = null;
    token = null;
    userPhone = null;
    userBio = null;
    userGender = null;
    userBirthDate = null;
    
    return {"status": "success", "message": "Logout berhasil"};
  }

  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String bio,
    required String gender,
    required DateTime? birthDate,
    required String phone,
    required String email,
  }) async {
    if (token == null) {
      return {
        "status": "error",
        "message": "Pengguna belum login. Token tidak tersedia.",
      };
    }
    
    // Format Tanggal Lahir ke format YYYY-MM-DD (format standar database)
    String? formattedBirthDate = birthDate != null
        ? DateFormat('yyyy-MM-dd').format(birthDate)
        : null;


    final response = await http.post(
      // ASUMSI: Endpoint untuk update adalah /profile/update
      Uri.parse("$baseUrl/profile/update"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Menggunakan token untuk otorisasi
      },
      body: jsonEncode({
        "name": name,
        "bio": bio,
        "gender": gender,
        "birth_date": formattedBirthDate, // Kirim tanggal yang sudah diformat
        "phone": phone,
        "email": email,
      }),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Jika berhasil, perbarui data statis di ApiServices (cache lokal)
      username = name;
      userEmail = email;
      userPhone = phone;
      userBio = bio;
      userGender = gender;
      userBirthDate = birthDate;

      return {
        "status": "success",
        "message": data["message"] ?? "Profil berhasil diperbarui",
      };
    } else if (response.statusCode == 422) {
      // Kesalahan validasi
      if (data.containsKey("errors")) {
        final errors = data["errors"] as Map<String, dynamic>;
        String firstError = errors.values.first[0];
        return {"status": "error", "message": firstError};
      }
      return {
        "status": "error",
        "message": data["message"] ?? "Validasi gagal saat update profil.",
      };
    } else {
      // Kesalahan server lainnya
      return {
        "status": "error",
        "message": "Gagal update profil. Status: ${response.statusCode}",
      };
    }
  }
}