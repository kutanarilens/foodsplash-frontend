import 'package:flutter/material.dart';
import 'package:foodsplash/pages/akun_page.dart';
<<<<<<< HEAD
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/custompesanan.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';

=======
import 'package:foodsplash/pages/aktivitas_page.dart';
import 'package:foodsplash/pages/promo_page.dart';
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
import 'package:foodsplash/widgets/header_widget.dart';
import 'package:foodsplash/widgets/category_menu.dart';
import 'package:foodsplash/widgets/food_item_card.dart';
import 'package:foodsplash/widgets/promo_banner.dart';

class Homepage extends StatelessWidget {
<<<<<<< HEAD
  const Homepage({super.key});

=======
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
<<<<<<< HEAD
        // HeaderWidget bukan const
=======
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
        title: HeaderWidget(),
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
<<<<<<< HEAD
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PromoBanner bukan const
            PromoBanner(),
            const SizedBox(height: 20),
            // CategoryMenu bukan const
            CategoryMenu(),

            const Divider(
              height: 40,
              thickness: 8,
              color: Color(0xFFF3F3F3),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
=======
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PromoBanner(),

            SizedBox(height: 20),

            CategoryMenu(),

            Divider(height: 40, thickness: 8, color: Colors.grey[100]),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
              child: Text(
                'Most loved',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
<<<<<<< HEAD

            Row(
              children: [
                // ====== PRODUK 1 ======
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // alur: Homepage -> CustomPesananPage
                            builder: (_) => const CustomPesananPage(),
                          ),
                        );
                      },
                      child: FoodItemCard(
                        title: 'Mie Gacoan, Depok Kelapa Dua',
                        distance: '2.17 km',
                        rating: '4.8 5rb+ rating',
                      ),
=======
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: FoodItemCard(
                      title: 'Mie Gacoan, Depok Kelapa Dua',
                      distance: '2.17 km',
                      rating: '4.8 5rb+ rating',
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
                    ),
                  ),
                ),

<<<<<<< HEAD
                const SizedBox(width: 15),

                // ====== PRODUK 2 ======
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
=======
                SizedBox(width: 15),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: FoodItemCard(
                      title: 'Dadar Beredar, Kelapa Dua',
                      distance: '2.12 km',
                      rating: '4.6 2rb+ rating',
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
<<<<<<< HEAD

      // NAVBAR
      bottomNavigationBar: const _NavigationMenu(),
=======
      bottomNavigationBar: _NavigationMenu(),
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
    );
  }
}

class _NavigationMenu extends StatelessWidget {
<<<<<<< HEAD
  const _NavigationMenu({super.key});
=======
  const _NavigationMenu();
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02

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
<<<<<<< HEAD
                MaterialPageRoute(builder: (_) => const Homepage()),
              );
            }),
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              // ⬇️ Sekarang menuju PesananDiprosesPage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
              );
            }),
            _buildNavItem(Icons.percent, 'Promo', false, () {
              Navigator.pushReplacement(
                context,
                // PromoPage bukan const constructor
                MaterialPageRoute(builder: (_) => PromoPage()),
              );
            }),
            _buildNavItem(Icons.person_outline, 'Akun', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AkunPage()),
=======
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            }),

            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AktivitasPage()),
              );
            }),

            _buildNavItem(Icons.percent, 'Promo', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PromoPage()),
              );
            }),

            _buildNavItem(Icons.person_outline, 'Akun', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AkunPage()),
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 4b5e1b0349dc23ccdc371e802f91758212d7db02
