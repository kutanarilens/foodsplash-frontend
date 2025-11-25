import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/pesananselesai.dart';
import 'package:foodsplash/pages/pesanandibatalkan.dart';
import 'package:foodsplash/pages/track_order_page.dart';

class PesananDikirimPage extends StatelessWidget {
  const PesananDikirimPage({super.key});

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StatusTabs(selected: OrderStatus.dikirim),
          SizedBox(height: 16),
          _OrderCardDikirim(),
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
    return Row(
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
            // sudah di halaman Dikirim
          },
        ),
        const SizedBox(width: 8),
        _statusChip(
          context,
          label: 'Selesai',
          isActive: selected == OrderStatus.selesai,
          onTap: () {
            if (selected == OrderStatus.selesai) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const PesananSelesaiPage(),
              ),
            );
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
            color:
                isActive ? const Color(0xFF32B7E8) : const Color(0xFFDEDEDE),
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

/* ----------------------------- KARTU DIKIRIM ----------------------------- */

class _OrderCardDikirim extends StatelessWidget {
  const _OrderCardDikirim();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header toko + status
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0x3333B8E8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star,
                          size: 11, color: Color(0xFF33B8E8)),
                      SizedBox(width: 3),
                      Text(
                        '4.4',
                        style: TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Ncis Official Store',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Dikirim',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF33B8E8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Info produk
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/martabak.png',
                    width: 90,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Martabak Telur, ncis ganteng',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Telor Ayam, Telor Bebek',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '2x',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total 2 Produk: Rp 60.000',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Strip info pengiriman
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x99CDF7F1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFCEF7F1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Estimasi Tiba: 08 Januari, 13.30',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF98C8C1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pesanan sedang dikirim ke alamat',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Tombol Lacak
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrackOrderPage(), // pakai default orderNo & ETA
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF33B8E8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Lacak Pesanan Anda',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF33B8E8),
                  ),
                ),
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
                  MaterialPageRoute(builder: (_) => Homepage()),
                );
              },
            ),
            _buildNavItem(
              context,
              icon: Icons.article_outlined,
              label: 'Aktivitas',
              isActive: current == _NavItem.aktivitas,
              onTap: () {
                // sudah di aktivitas
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