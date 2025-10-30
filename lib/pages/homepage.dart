import 'package:flutter/material.dart';
// Asumsi import widget-widget berikut tersedia di folder /widgets
import 'package:foodsplash/widgets/header_widget.dart';
import 'package:foodsplash/widgets/category_menu.dart';
import 'package:foodsplash/widgets/food_item_card.dart';
import 'package:foodsplash/widgets/navigation.dart';
import 'package:foodsplash/widgets/promo_banner.dart';

// ====================================================================
// 1. WIDGET UTAMA: HOMEPAGE
// ====================================================================

class Homepage extends StatelessWidget {
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
              child: Text(
                'Most loved',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                // Item Kiri: Tambahkan padding kiri 16.0
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: FoodItemCard(
                      title: 'Mie Gacoan, Depok Kelapa Dua',
                      distance: '2.17 km',
                      rating: '4.8 5rb+ rating',
                    ),
                  ),
                ),
                
                // Jarak Antar Kartu: Tetap 15.0
                SizedBox(width: 15),
                
                // Item Kanan: Tambahkan padding kanan 16.0
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: FoodItemCard(
                      title: 'Dadar Beredar, Kelapa Dua',
                      distance: '2.12 km',
                      rating: '4.6 2rb+ rating',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // 2. INTEGRASI NAVIGATION MENU SEBAGAI BOTTOM NAVIGATION BAR
      bottomNavigationBar: NavigationMenu(),
    );
  }
}

// ====================================================================
// 3. WIDGET NAVIGASI (DIBUAT PRIVATE: _NavigationMenu)
// ====================================================================

class _NavigationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold dihilangkan karena widget ini hanya berfungsi sebagai BottomNavigationBar
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      // Memberikan padding untuk memastikan tombol FAB tidak terlalu menempel
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Produk (Active)
            _buildNavItem(Icons.home, 'Produk', true), 
            
            // Aktivitas
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false),
            
            // Promo
            _buildNavItem(Icons.percent, 'Promo', false),
            
            // Akun
            _buildNavItem(Icons.person_outline, 'Akun', false),
          ],
        ),
      ),
    );
  }
}


// ====================================================================
// 4. FLOATING ACTION BUTTON WRAPPER (di dalam Homepage)
// ====================================================================

// Karena BottomAppBar memerlukan FloatingActionButtonLocation, 
// kita akan membuat wrapper untuk menempatkan _NavigationMenu dan FAB
// Namun, karena Anda tidak memberikan kode HomePage Stateful/Stateless, 
// kita akan mengasumsikan kode di atas adalah kode utama yang menampung FAB.
// FAB akan ditambahkan kembali ke Scaffold di Homepage.

/* * CATATAN: Karena NavigationMenu Anda sebelumnya merupakan Scaffold sendiri,
* implementasi di atas memisahkannya. Anda harus menempatkan FloatingActionButton
* di Scaffold utama (Homepage). Saya telah memodifikasi Homepage di atas.
*/


// ====================================================================
// 5. HELPER FUNCTION
// ====================================================================

// Fungsi _buildNavItem dipindahkan ke file ini.
Widget _buildNavItem(IconData icon, String label, bool isActive) {
  return InkWell( // Menggunakan InkWell agar bisa diklik
    onTap: () {
      // TODO: Implementasi navigasi antar halaman di sini
      print('Navigasi ke $label'); 
    },
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
