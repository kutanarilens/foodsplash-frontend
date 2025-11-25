// lib/pages/nearest_food_page.dart
import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage.dart';
import '../models/menu_item.dart';
import '../services/menu_service.dart';
import 'package:foodsplash/pages/aktivitas_page.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/custompesanan.dart';


class NearestFoodPage extends StatefulWidget {
  const NearestFoodPage({super.key});

  @override
  State<NearestFoodPage> createState() => _NearestFoodPageState();
}

class _NearestFoodPageState extends State<NearestFoodPage> {
  final _svc = MenuService();
  late Future<List<MenuItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = _svc.fetchNearestMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderCard(),
            const _FilterBar(),
            Expanded(
              child: FutureBuilder<List<MenuItem>>(
                future: _future,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(
                      child: Text(
                        'Gagal memuat data: ${snap.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  final items = snap.data ?? [];
                  if (items.isEmpty) {
                    return const Center(
                      child: Text('Belum ada makanan terdekat.'),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final menu = items[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomPesananPage(menu: menu),
                            ),
                          );
                        },
                        child: _MenuTile(item: menu),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _NavigationMenu(),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff1fb6ff),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Makanan Terdekat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Di sekitar kamu',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Row(
        children: const [
          _ChipBtn(label: 'Filter', icon: Icons.filter_list),
          SizedBox(width: 10),
          _ChipBtn(label: 'Urutkan', icon: Icons.expand_more),
          SizedBox(width: 10),
          _ChipBtn(label: 'Bintang 4.5', icon: Icons.star_rounded),
        ],
      ),
    );
  }
}

class _ChipBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  const _ChipBtn({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          Icon(icon, size: 18),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final MenuItem item;
  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final muted = Colors.black.withOpacity(0.55);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 78,
              height: 58,
              color: const Color(0xffeaeaea),
              child: item.imageUrl == null
                  ? const Icon(Icons.image, size: 28, color: Colors.grey)
                  : Image.network(item.imageUrl!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaMenu,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item.kategori ?? '-',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${item.status}',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.verified, size: 16, color: Color(0xff1fb6ff)),
                    const SizedBox(width: 6),
                    Text(
                      'Mulai dari Rp ${item.harga.toStringAsFixed(0)}',
                      style: TextStyle(color: muted, fontSize: 12.5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xffe8f6ff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 16, color: Color(0xff1fb6ff)),
                    const SizedBox(width: 2),
                    Text(
                      (item.avgRating ?? 0).toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${item.reviewsCount ?? 0} ulasan',
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
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
            _buildNavItem(Icons.home, 'Produk', true, () {
              Navigator.pushReplacement(
                context,
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