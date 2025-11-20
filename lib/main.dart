import 'package:flutter/material.dart';
import 'package:foodsplash/pages/login.dart';
import 'package:foodsplash/pages/registrasi.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/aktivitas_page.dart';
import 'package:foodsplash/pages/custompesanan.dart';
import 'package:foodsplash/pages/customalamat.dart';
import 'package:foodsplash/pages/rincian_pesanan_page.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/pesanandikirim.dart';
import 'package:foodsplash/pages/pesananselesai.dart';
import 'package:foodsplash/pages/pesanandibatalkan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodSplash Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, // Mempertahankan pengaturan tema
      ),

      /// 🔹 Start dari halaman login
      initialRoute: '/login',

    
      routes: { // Named Routes
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrasiPage(),
        '/home': (context) => const Homepage(),
        '/aktivitas': (context) => const AktivitasPage(),
        '/promo': (context) => PromoPage(),
        '/akun': (context) => const AkunPage(),
        '/custom-pesanan': (context) => const CustomPesananPage(),
        '/custom-alamat': (context) => const CustomAlamatPage(),
        '/pesanan-diproses': (context) => const PesananDiprosesPage(),
        '/pesanan-dikirim': (context) => const PesananDikirimPage(),
        '/pesanan-selesai': (context) => const PesananSelesaiPage(),
        '/pesanan-dibatalkan': (context) => const PesananDibatalkanPage(),
      },


      onGenerateRoute: (settings) {
        // Menangani rute yang membutuhkan argumen (seperti data pesanan)
        if (settings.name == '/rincian-pesanan') {

          final args = settings.arguments as Map<String, dynamic>?;

          final int qty = args?['qty'] as int? ?? 1;
          final int totalPrice = args?['totalPrice'] as int? ?? 60000;
          final String note = args?['note'] as String? ?? '';

          return MaterialPageRoute(
            builder: (_) => RincianPesananPage(
              qty: qty,
              totalPrice: totalPrice,
              note: note,
            ),
          );
        }

        // Default route jika rute yang diminta tidak ditemukan
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      },
    );
  }
}