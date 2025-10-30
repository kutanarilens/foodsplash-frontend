import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage%20_2.dart';
import 'package:foodsplash/pages/homepage.dart';

// Widget utama yang dapat digunakan kembali di seluruh aplikasi
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      // Memberikan padding untuk memastikan tombol FAB tidak terlalu menempel
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Produk (Active)
            _buildNavItem(Icons.home, 'Produk', true, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            }),

            // Aktivitas
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage_2()),
              );
            }),

            // Promo
            _buildNavItem(
              Icons.percent,
              'Promo',
              false,
              () => print('Go to Promo'),
            ),

            // Akun
            _buildNavItem(
              Icons.person_outline,
              'Akun',
              false,
              () => print('Go to Akun'),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function dipindahkan ke file ini dan ditambahkan callback onTap
Widget _buildNavItem(
  IconData icon,
  String label,
  bool isActive,
  VoidCallback onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.lightBlue : Colors.grey),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.lightBlue : Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
      ],
    ),
  );
}
