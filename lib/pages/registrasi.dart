import 'package:flutter/material.dart';
import 'package:foodsplash/layout/data/api_services.dart';
import 'package:foodsplash/pages/login.dart';

class RegistrasiPage extends StatefulWidget {
  @override
  State<RegistrasiPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";
  String passwordConfirmation = "";

  bool loading = false;
  String? errorMessage;
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _submit() async {
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

    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });

      try {
        final result = await ApiServices.register(
          name,
          email,
          password,
          passwordConfirmation,
        );

        if (result["status"] == "success") {
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
          setState(() {
            String apiMessage = result["message"] ?? "Pendaftaran gagal.";

            if (apiMessage.contains("email") && apiMessage.contains("taken")) {
              errorMessage =
                  "Akun sudah terdaftar. Silakan gunakan email lain.";
            } else {
              errorMessage = apiMessage;
            }
          });
        }
      } catch (e) {
        setState(() {
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                  child: Image.asset(
                    'assets/images/foodsplash.png',
                    height: 50,
                  ),
                ),
                const SizedBox(height: 75),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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

                      TextFormField(
                        onChanged: (value) => name = value,
                        decoration: _inputDecoration(labelText: "Nama Lengkap"),
                        validator: (value) => value == null || value.isEmpty
                            ? "Nama Lengkap wajib diisi"
                            : null,
                      ),
                      const SizedBox(height: 16),

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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Konfirmasi password wajib diisi";
                          }
                          if (value != password) {
                            return "Password tidak sama";
                          }
                          return null;
                        },
                      ),

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
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                      const SizedBox(height: 150),
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
