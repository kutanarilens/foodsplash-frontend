import 'package:flutter/material.dart';
import 'package:foodsplash/layout/data/api_services.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/login.dart';
// import 'package:foodsplash/pages/wave_background.dart';

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
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });
      try {
        final result = await ApiServices.login(email, password);
        if (result["status"] == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Homepage()),
          );
        }
      } catch (e) {
        setState(() {
          errorMessage = "Terjadi Kesalahan ${e.toString()}";
        });
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang atas putih
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
          // 1. Bagian Gelombang (Wave Background)
          // Kita akan menempatkan ini di bawah menggunakan widget kustom (WaveBackground)
          Align(
            alignment: Alignment.bottomCenter,
            // child: ,
          ),

          // 2. Konten Utama (Logo dan Tombol)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50), // Jarak dari atas
                // Logo foodSplash (Ganti dengan Image.asset)
                Image.asset(
                  'assets/images/foodsplash.png', // Pastikan path benar
                  height: 150,
                ),

                SizedBox(height: 100),
                // Spacer untuk mendorong tombol ke bawah
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
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _submit,
                                child: Text("Login"),
                              ),
                      ],
                    ),
                  ),
                ),
                // _buildUsernameField(
                //   label: "Email",
                //   hintText: "Masukkan Email",
                //   keyboardType: TextInputType.emailAddress,

                // ),
                // _buildPasswordTextField(
                //   label: 'Password',
                //   hintText: 'Masukkan password',
                //   isVisible: _isPasswordVisible,
                //   onToggleVisibility: () {
                //     setState(() {
                //       _isPasswordVisible = !_isPasswordVisible;
                //     });
                //   },
                // ),
                // SizedBox(height: 20),

                // // Tombol Masuk
                // _buildLoginButton(
                //   text: 'Masuk',
                //   color: Colors.white,
                //   textColor: Colors.blue,
                //   onPressed: _submit,
                // ),
                SizedBox(height: 20),
                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi pembantu untuk membuat tombol
  Widget _buildLoginButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

Widget _buildButton({
  required String text,
  required Color color,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return Container(
    width: double.maxFinite,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget _buildUsernameField({
  required String label,
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(height: 8),
      TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          isDense: true,
        ),
      ),
    ],
  );
}

Widget _buildPasswordTextField({
  required String label,
  required String hintText,
  required bool isVisible,
  required VoidCallback onToggleVisibility,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(height: 8),
      TextField(
        obscureText: !isVisible, // Sembunyikan teks jika !isVisible
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          isDense: true,
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
      ),
    ],
  );
}
