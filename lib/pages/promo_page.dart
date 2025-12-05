import 'package:flutter/material.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';

class PromoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Promo Tersedia',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        // automaticallyImplyLeading: false,
        // toolbarHeight: 120,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [SizedBox(height: 8)],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [SizedBox(height: 8)],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [SizedBox(height: 8)],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: _NavigationMenu(),
    );
  }
}

class _NavigationMenu extends StatelessWidget {
  const _NavigationMenu();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home, 'Produk', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            }),

            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
              );
            }),

            _buildNavItem(Icons.percent, 'Promo', true, () {}),

            _buildNavItem(Icons.person_outline, 'Akun', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AkunPage()),
              );
            }),
          ],
        ),
      ),
    );
  }
}

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
