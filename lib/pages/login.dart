import 'package:flutter/material.dart';
import 'package:foodsplash/pages/login_method.dart';
import 'package:foodsplash/pages/registrasi.dart';
// import 'package:foodsplash/pages/wave_background.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang atas putih
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
                SizedBox(height: 150), // Jarak dari atas
                // Logo foodSplash (Ganti dengan Image.asset)
                Image.asset(
                  'assets/images/foodsplash.png', // Pastikan path benar
                  height: 150,
                ),

                // Spacer untuk mendorong tombol ke bawah
                Spacer(),

                // Tombol Masuk
                _buildButton(
                  text: 'Masuk',
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginMethod()),
                    );
                  },
                ),
                SizedBox(height: 15),

                // Tombol Belum Punya Akun? Daftar
                _buildButton(
                  text: 'Belum Punya Akun? Daftar',
                  color: Color(0xFF5AB6FF), // Biru agak tua
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegistrasiPage()),
                    );
                    // Logika navigasi ke halaman daftar
                  },
                ),

                // Jarak dari bawah
                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi pembantu untuk membuat tombol
  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
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
