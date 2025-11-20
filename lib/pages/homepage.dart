import 'package:flutter/material.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/aktivitas_page.dart'; // Digabungkan dari versi lama
import 'package:foodsplash/pages/custompesanan.dart';
import 'package:foodsplash/pages/pesanandiproses.dart'; // Digunakan untuk navigasi 'Aktivitas'
import 'package:foodsplash/widgets/header_widget.dart';
import 'package:foodsplash/widgets/category_menu.dart';
import 'package:foodsplash/widgets/food_item_card.dart';
import 'package:foodsplash/widgets/promo_banner.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key}); // Konstruktor const dipertahankan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HeaderWidget(),
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PromoBanner(),
            const SizedBox(height: 20),
            CategoryMenu(),

            const Divider(
              height: 40,
              thickness: 8,
              color: Color(0xFFF3F3F3),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Most loved',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              children: [
                // ====== PRODUK 1 (dengan InkWell) ======
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Navigasi ke halaman kustomisasi pesanan
                            builder: (_) => const CustomPesananPage(),
                          ),
                        );
                      },
                      child: FoodItemCard(
                        title: 'Mie Gacoan, Depok Kelapa Dua',
                        distance: '2.17 km',
                        rating: '4.8 5rb+ rating',
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // ====== PRODUK 2 (dengan InkWell) ======
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CustomPesananPage(),
                          ),
                        );
                      },
                      child: FoodItemCard(
                        title: 'Dadar Beredar, Kelapa Dua',
                        distance: '2.12 km',
                        rating: '4.6 2rb+ rating',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // NAVBAR
      bottomNavigationBar: const _NavigationMenu(),
    );
  }
}

class _NavigationMenu extends StatelessWidget {
  const _NavigationMenu({super.key}); // Menggunakan konstruktor const standar

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home, 'Produk', true, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Homepage()),
              );
            }),
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              // Navigasi ke PesananDiprosesPage (dari versi HEAD)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
              );
            }),
            _buildNavItem(Icons.percent, 'Promo', false, () {
              Navigator.pushReplacement(
                context,
                // PromoPage bukan const
                MaterialPageRoute(builder: (_) => PromoPage()),
              );
            }),
            _buildNavItem(Icons.person_outline, 'Akun', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AkunPage()),
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