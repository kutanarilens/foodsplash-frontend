import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/pesanandikirim.dart';
import 'package:foodsplash/pages/pesananselesai.dart';

class PesananDibatalkanPage extends StatelessWidget {
  const PesananDibatalkanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {},
        // ),
        centerTitle: true,
        title: const Text(
          'Riwayat Aktivitas',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const _StatusTabs(selected: OrderStatus.dibatalkan),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [_CanceledOrderCard()],
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
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
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
                MaterialPageRoute(builder: (_) => const PesananDikirimPage()),
              );
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
                MaterialPageRoute(builder: (_) => const PesananSelesaiPage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _statusChip(
            context,
            label: 'Dibatalkan',
            isActive: selected == OrderStatus.dibatalkan,
            onTap: () {
              // sudah di halaman dibatalkan
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
            color: isActive ? const Color(0xFF32B7E8) : const Color(0xFFDEDEDE),
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

/* ---------------------------- CARD PESANAN BATAL ------------------------- */

class _CanceledOrderCard extends StatelessWidget {
  const _CanceledOrderCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header: nama toko + status
            Row(
              children: const [
                Text(
                  'Ayam Bakar Galak, Batang',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  'Dibatalkan',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              '1 Januari 2025, 10.23',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const SizedBox(height: 10),

            // isi produk
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/ayam_bakar.jpg', // sesuaikan dengan asetmu
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ayam Bakar Paket Jumbo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Nasi, ayam bakar, sambal, lalapan',
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Alasan: Pembayaran tidak berhasil',
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Rp.53.000',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // banner status batal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFC4C4)),
              ),
              child: const Text(
                'Pesanan dibatalkan. Kamu bisa melakukan pemesanan ulang jika masih ingin membeli menu ini.',
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 8),

            // Pesan Ulang
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Text(
                  'Pesan Ulang  →',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF33B8E8),
                    fontWeight: FontWeight.w600,
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
                // sudah di menu aktivitas
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
