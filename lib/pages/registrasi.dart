import 'package:flutter/material.dart';
import 'package:foodsplash/pages/login.dart';

/*{
    "status": "success",
    "message": "User registered successfully",
    "user": {
        "name": "agin",
        "email": "agin@gmail.com",
        "password": "$2y$12$mNKB4ZtWZnMRgHl/yYkBF.hfQdf7NwC0m3w3ww22bDTR2brjyx/RW",
        "updated_at": "2025-10-29T13:42:28.000000Z",
        "created_at": "2025-10-29T13:42:28.000000Z",
        "id": 5
    },
    "token": "13|9fDn3RvFBz3zencCl8QXTMKFrLu0EdWzZQK188Huf38cbddd"
}
*/
class RegistrasiPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// class _LoginMethodState extends State<LoginMethod> {
//   final _formKey = GlobalKey<FormState>();
//   String name = "";
//   String email = "";
//   String password = "";
//   String password_confirmation = "";
//   bool loading = false;
//   String? errorMessage;
//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         loading = true;
//         errorMessage = null;
//       });
//       try {
//         final result = await ApiServices.login(email, password);
//         if (result["status"] == "success") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => Homepage()),
//           );
//         }
//       } catch (e) {
//         setState(() {
//           errorMessage = "Terjadi Kesalahan ${e.toString()}";
//         });
//       } finally {
//         setState(() {
//           loading = false;
//         });
//       }
//     }
//   }
// }

class _RegisterPageState extends State<RegistrasiPage> {
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
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
          "Daftar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            // child: ,
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/foodsplash.png',
                  height: 100,
                  width: 230,
                ),
                SizedBox(height: 30),
                _buildTextField(
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                ),
                SizedBox(height: 15),
                _buildTextField(dec
                  label: 'Email',
                  hintText: 'Masukkan email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),

                // Input Password
                _buildPasswordTextField(
                  label: 'Password',
                  hintText: 'Masukkan password',
                  isVisible: _isPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 15),

                _buildPasswordTextField(
                  label: 'Konfirmasi Password',
                  hintText: 'Konfirmasi password',
                  isVisible: _isConfirmPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    'Password minimal 6 Karakter',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 25),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _agreedToTerms = newValue ?? false;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: 'Saya menyetujui '),
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
                            TextSpan(text: ' di\nFoodSplash'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Tombol Daftar
                _buildRegisterButton(
                  text: 'Daftar',
                  onPressed: _agreedToTerms
                      ? () {
                          // TODO: Tambahkan logika pendaftaran di sini
                          print('Daftar ditekan!');
                        }
                      : null, // Tombol nonaktif jika belum menyetujui
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Teks di bagian paling bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(text: 'Dengan mendaftar saya menyetujui '),
                    TextSpan(
                      text: 'Syarat & Ketentuan',
                      style: TextStyle(
                        color: Color(0xFFC7E6FF),
                        fontWeight: FontWeight.bold,
                      ), // Warna biru lebih terang
                      // TODO: Tambahkan onTap untuk navigasi ke Syarat & Ketentuan
                    ),
                    TextSpan(text: ' dan\n'),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: TextStyle(
                        color: Color(0xFFC7E6FF),
                        fontWeight: FontWeight.bold,
                      ), // Warna biru lebih terang
                      // TODO: Tambahkan onTap untuk navigasi ke Kebijakan Privasi
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pembantu untuk TextField biasa
  Widget _buildTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
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

  // Widget pembantu untuk TextField Password
  Widget _buildPasswordTextField({
    required String label,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
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

  // Widget pembantu untuk tombol Daftar
  Widget _buildRegisterButton({required String text, VoidCallback? onPressed}) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed, // Akan null jika tidak disetujui
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF67B5FF), // Warna biru tua
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          // Mengatur warna saat tombol nonaktif
          foregroundColor: Colors.white, // Text color when enabled
          disabledBackgroundColor:
              Colors.grey[300], // Background color when disabled
          disabledForegroundColor: Colors.grey[600], // Text color when disabled
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
