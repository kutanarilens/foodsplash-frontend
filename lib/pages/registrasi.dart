import 'package:flutter/material.dart';
import 'package:foodsplash/layout/data/api_services.dart';
import 'package:foodsplash/pages/login.dart';

class RegistrasiPage extends StatefulWidget {
  @override
  State<RegistrasiPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();

  // REFRAKTOR: Kembali menggunakan variabel String sederhana
  String name = "";
  String email = "";
  String password = "";
  String passwordConfirmation = ""; // Menggunakan nama yang lebih jelas

  bool loading = false;
  String? errorMessage;
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _submit() async {
    // 1. Validasi Terms & Conditions
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Anda harus menyetujui Ketentuan dan Kebijakan Privasi.',
          ),
        ),
      );
      return;
    }

    // Pastikan validasi form berhasil sebelum melanjutkan
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });

      try {
        // Panggilan ApiServices.register menggunakan variabel String
        final result = await ApiServices.register(
          name, // Mengambil nilai Nama
          email, // Mengambil nilai Email
          password, // Mengambil nilai Password
          passwordConfirmation, // Mengambil nilai Konfirmasi Password
        );

        if (result["status"] == "success") {
          // Registrasi Berhasil: Tampilkan pesan sukses dan navigasi ke Login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi Berhasil! Silakan masuk.'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        } else {
          // Registrasi Gagal (Error Validasi dari API)
          setState(() {
            // ...
            String apiMessage = result["message"] ?? "Pendaftaran gagal.";

            // Contoh penyesuaian jika Anda tahu pesan spesifik dari Laravel
            if (apiMessage.contains("email") && apiMessage.contains("taken")) {
              // PESAN INI AKAN MUNCUL di Flutter jika email sudah ada!
              errorMessage =
                  "Akun sudah terdaftar. Silakan gunakan email lain.";
            } else {
              errorMessage = apiMessage;
            }
          });
        }
      } catch (e) {
        // Kesalahan Jaringan
        setState(() {
          // Tambahkan pesan yang lebih spesifik jika ini adalah Error tipe Exception
          errorMessage = "Kesalahan: ${e.toString()}. Cek koneksi server Anda.";
        });
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Karena tidak menggunakan Controller, dispose tidak diperlukan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Daftar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            // Gunakan SingleChildScrollView untuk menghindari overflow
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Logo
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                  child: Image.asset(
                    'assets/images/foodsplash.png', // Pastikan path benar
                    height: 50,
                  ),
                ),
                const SizedBox(height: 75),

                // Form Registrasi
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Pesan Error dari API
                      if (errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Nama Lengkap
                      TextFormField(
                        onChanged: (value) => name = value,
                        decoration: _inputDecoration(labelText: "Nama Lengkap"),
                        validator: (value) => value == null || value.isEmpty
                            ? "Nama Lengkap wajib diisi"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        onChanged: (value) => email = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(labelText: "Email"),
                        validator: (value) =>
                            value == null ||
                                value.isEmpty ||
                                !value.contains("@")
                            ? "Email Tidak Valid"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        onChanged: (value) => password = value,
                        obscureText: !_isPasswordVisible,
                        decoration: _inputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty || value.length < 6
                            ? "Password minimal 6 karakter"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Konfirmasi Password
                      TextFormField(
                        onChanged: (value) => passwordConfirmation = value,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: _inputDecoration(
                          labelText: "Konfirmasi Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        // *** Perbaikan Validator ***
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Konfirmasi password wajib diisi";
                          }
                          // Cek kesamaan dengan nilai password yang pertama
                          if (value != password) {
                            // Membandingkan dengan variabel 'password'
                            return "Password tidak sama";
                          }
                          return null;
                        },
                      ),

                      // Teks bantuan untuk password (sesuai gambar)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Password minimal 6 Karakter",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Checkbox Persetujuan
                      Row(
                        children: [
                          Checkbox(
                            value: _agreedToTerms,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _agreedToTerms = newValue ?? false;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          const Flexible(
                            child: Text.rich(
                              TextSpan(
                                text: 'Saya menyetujui ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Ketentuan',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: ' dan '),
                                  TextSpan(
                                    text: 'Kebijakan Privasi',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: ' di FoodSplash'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tombol Daftar
                      loading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  1000,
                                  112,
                                  148,
                                  255,
                                ),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(
                                  double.infinity,
                                  50,
                                ), // Membuat tombol penuh lebar
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _submit,
                              child: const Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                      const SizedBox(
                        height: 150,
                      ), // Tambahan padding agar konten terlihat di atas background biru
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function untuk InputDecoration yang lebih bersih
  InputDecoration _inputDecoration({
    required String labelText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      suffixIcon: suffixIcon,
    );
  }
}
