import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/pesanandikirim.dart';
import 'package:foodsplash/pages/custompesanan.dart';
import 'package:foodsplash/pages/pesanandibatalkan.dart';


class PesananSelesaiPage extends StatelessWidget {
  const PesananSelesaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Riwayat Aktivitas',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const _StatusTabs(selected: OrderStatus.selesai),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _dummyFinishedOrders.length,
              itemBuilder: (context, index) {
                final order = _dummyFinishedOrders[index];
                return _FinishedOrderTile(order: order);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _BottomNavBar(current: _NavItem.aktivitas),
    );
  }
}

/* ------------------------- STATUS TABS (TAG ATAS) ------------------------ */

enum OrderStatus { diproses, dikirim, selesai, dibatalkan }

class _StatusTabs extends StatelessWidget {
  final OrderStatus selected;

  const _StatusTabs({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _statusChip(
            context,
            label: 'Diproses',
            isActive: selected == OrderStatus.diproses,
            onTap: () {
              if (selected == OrderStatus.diproses) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const PesananDiprosesPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          _statusChip(
            context,
            label: 'Dikirim',
            isActive: selected == OrderStatus.dikirim,
            onTap: () {
              if (selected == OrderStatus.dikirim) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const PesananDikirimPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          _statusChip(
            context,
            label: 'Selesai',
            isActive: selected == OrderStatus.selesai,
            onTap: () {
              // sudah di halaman Selesai
            },
          ),
          const SizedBox(width: 8),
          _statusChip(
  context,
  label: 'Dibatalkan',
  isActive: selected == OrderStatus.dibatalkan,
  onTap: () {
    if (selected == OrderStatus.dibatalkan) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PesananDibatalkanPage(),
      ),
    );
  },
),

        ],
      ),
    );
  }

  Widget _statusChip(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isActive
                ? const Color(0xFF32B7E8)
                : const Color(0xFFDEDEDE),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------- MODEL DUMMY PESANAN -------------------------- */

class _FinishedOrder {
  final String name;
  final String dateTime;
  final String price;
  final String imagePath;

  const _FinishedOrder({
    required this.name,
    required this.dateTime,
    required this.price,
    required this.imagePath,
  });
}

// 5 dummy seperti di desain
const List<_FinishedOrder> _dummyFinishedOrders = [
  _FinishedOrder(
    name: 'Martabak Telur,ncis ganteng',
    dateTime: '5 Januari 2025, 08.23',
    price: 'Rp.85.000',
    imagePath: 'assets/images/martabak.png',
  ),
  _FinishedOrder(
    name: 'Ayam Bakar Galak,Batang',
    dateTime: '1 Januari 2025, 10.23',
    price: 'Rp.53.000',
    imagePath: 'assets/images/ayam_bakar.jpg', // ganti sesuai asetmu
  ),
  _FinishedOrder(
    name: 'GFC, Radakuning',
    dateTime: '25 Desember 2024, 09.23',
    price: 'Rp.33.000',
    imagePath: 'assets/images/ayam_goreng.jpg', // ganti sesuai asetmu
  ),
  _FinishedOrder(
    name: 'Dadar Beredar, Depok',
    dateTime: '15 Desember 2024, 09.00',
    price: 'Rp.49.000',
    imagePath: 'assets/images/dadarberedar.jpg', // ganti sesuai asetmu
  ),
  _FinishedOrder(
    name: 'Mie Gacoan',
    dateTime: '02 Desember 2024, 11.00',
    price: 'Rp.33.000',
    imagePath: 'assets/images/miegacoan.jpg', // ganti sesuai asetmu
  ),
];

/* -------------------------- TILE / CARD PESANAN -------------------------- */

class _FinishedOrderTile extends StatelessWidget {
  final _FinishedOrder order;

  const _FinishedOrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                order.imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.dateTime,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      // nanti bisa dihubungkan dengan id produk ke backend,
                      // sekarang dulu: menuju ke halaman CustomPesananPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomPesananPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Pesan Ulang  →',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF33B8E8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              order.price,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------- BOTTOM NAVBAR ----------------------------- */

enum _NavItem { produk, aktivitas, promo, akun }

class _BottomNavBar extends StatelessWidget {
  final _NavItem current;

  const _BottomNavBar({required this.current});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              context,
              icon: Icons.home,
              label: 'Produk',
              isActive: current == _NavItem.produk,
              onTap: () {
                if (current == _NavItem.produk) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Homepage()),
                );
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.article_outlined,
              label: 'Aktivitas',
              isActive: current == _NavItem.aktivitas,
              onTap: () {
                // sudah di menu Aktivitas (tab selesai)
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.percent,
              label: 'Promo',
              isActive: current == _NavItem.promo,
              onTap: () {
                if (current == _NavItem.promo) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PromoPage()),
                );
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.person_outline,
              label: 'Akun',
              isActive: current == _NavItem.akun,
              onTap: () {
                if (current == _NavItem.akun) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AkunPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
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
}
