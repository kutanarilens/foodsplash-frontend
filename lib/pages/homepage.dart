import 'package:flutter/material.dart';
import 'package:foodsplash/models/menu_item.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/custompesanan.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/widgets/header_widget.dart';
import 'package:foodsplash/widgets/category_menu.dart';
import 'package:foodsplash/widgets/food_item_card.dart';
import 'package:foodsplash/widgets/promo_banner.dart';
import 'package:foodsplash/services/menu_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<MenuItem>> _futureMenus;

  @override
  void initState() {
    super.initState();
    _futureMenus = MenuService().fetchNearestMenus(); // or fetchMenus()
  }

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

            const Divider(height: 40, thickness: 8, color: Color(0xFFF3F3F3)),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Most loved',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            FutureBuilder<List<MenuItem>>(
              future: _futureMenus,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final menus = snapshot.data!;
                if (menus.isEmpty) {
                  return const Center(child: Text("Tidak ada menu ditemukan"));
                }
                final first = menus[0];
                final second = menus.length > 1 ? menus[1] : null;

                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CustomPesananPage(menu: first),
                              ),
                            );
                          },
                          child: FoodItemCard(item: first),
                        ),
                      ),

                      const SizedBox(width: 15),

                      if (second != null)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CustomPesananPage(menu: second),
                                ),
                              );
                            },
                            child: FoodItemCard(item: second),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _NavigationMenu(),
    );

    // NAVBAR
  }
}

class _NavigationMenu extends StatelessWidget {
  const _NavigationMenu(); // Menggunakan konstruktor const standar

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
