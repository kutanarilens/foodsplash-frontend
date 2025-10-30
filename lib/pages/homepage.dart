import 'package:flutter/material.dart';
import 'package:foodsplash/widgets/header_widget.dart';
import 'package:foodsplash/widgets/category_menu.dart';
import 'package:foodsplash/widgets/food_item_card.dart';
import 'package:foodsplash/widgets/promo_banner.dart';

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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FoodItemCard(
                      title: 'Mie Gacoan, Depok Kelapa Dua',
                      distance: '2.17 km',
                      rating: '4.8 5rb+ rating',
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: FoodItemCard(
                      title: 'Dadar Beredar, Kelapa Dua',
                      distance: '2.12 km',
                      rating: '4.6 2rb+ rating',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.home, 'Produk', true),
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false),
            SizedBox(width: 40), 
            _buildNavItem(Icons.percent, 'Promo', false),
            _buildNavItem(Icons.person_outline, 'Akun', false),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.lightBlue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
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
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
