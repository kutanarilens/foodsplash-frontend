import 'package:flutter/material.dart';
import 'package:foodsplash/layout/data/api_services.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/login.dart';
import 'package:foodsplash/pages/registrasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMethod extends StatefulWidget {
  @override
  State<LoginMethod> createState() => _LoginMethodState();
}

class _LoginMethodState extends State<LoginMethod> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool loading = false;
  String? errorMessage;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });

      try {
        final result = await ApiServices.login(email, password);

        if (result["status"] == "success") {
          // ⬇️ AMBIL TOKEN DARI HASIL LOGIN
          // SESUAIKAN KEY-NYA DENGAN RESPON BACKEND-MU
          // contoh kalau respons: { status: "success", token: "xxx" }
          String? token = result["token"] as String?;

          // kalau di backend pakai nama lain (misal "access_token"),
          // bisa pakai fallback seperti ini:
          token ??= result["access_token"] as String?;

          if (token != null && token.isNotEmpty) {
            // ⬇️ SIMPAN TOKEN KE SHARED PREFERENCES
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('auth_token', token);
          }

          // ⬇️ SETELAH TOKEN TERSIMPAN, LANJUT KE HOMEPAGE
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Homepage()),
          );
        } else {
          // jika API mengembalikan status gagal
          setState(() {
            errorMessage = result["message"]?.toString() ?? "Login gagal";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "Terjadi Kesalahan ${e.toString()}";
        });
      } finally {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }
    }
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
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Align(alignment: Alignment.bottomCenter),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Image.asset('assets/images/foodsplash.png', height: 150),

                SizedBox(height: 100),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (errorMessage != null)
                          Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) => email = value,
                          validator: (value) =>
                              value == null || !value.contains("@")
                              ? "Email Tidak Valid"
                              : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          onChanged: (value) => password = value,
                          validator: (value) =>
                              value == null || value.length < 6
                              ? "Password minimal 6 karakter"
                              : null,
                        ),
                        SizedBox(height: 20),
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
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _submit,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegistrasiPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Belum Mempunyai Akun?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
