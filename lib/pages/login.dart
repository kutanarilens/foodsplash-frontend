import 'package:flutter/material.dart';
import 'package:foodsplash/pages/login_method.dart';
import 'package:foodsplash/pages/registrasi.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(alignment: Alignment.bottomCenter),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 150),
                Image.asset('assets/images/foodsplash.png', height: 150),
                Spacer(),
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
                _buildButton(
                  text: 'Belum Punya Akun? Daftar',
                  color: Color.fromARGB(255, 90, 182, 255),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrasiPage()),
                    );
                  },
                ),

                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

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