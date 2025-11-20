import 'package:flutter/material.dart';
import 'package:foodsplash/pages/nearest_food_page.dart'; // Import yang benar

class CategoryMenu extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.near_me, 'label': 'Terdekat', 'color': Colors.green},
    {'icon': Icons.local_offer, 'label': 'Pasti Ada Promo', 'color': Colors.red},
    {'icon': Icons.wb_sunny, 'label': '24 hours', 'color': Colors.amber},
    {'icon': Icons.favorite, 'label': 'Most loved', 'color': Colors.redAccent},
    {'icon': Icons.star, 'label': 'Best sellers', 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.map((item) {
          final bool isTerdekat = item['label'] == 'Terdekat'; // Logika penentuan item 'Terdekat'

          return InkWell( // Menggunakan InkWell untuk menambahkan fungsionalitas tap
            onTap: isTerdekat
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NearestFoodPage(),
                      ),
                    );
                  }
                : null, // Hanya item 'Terdekat' yang memiliki fungsi tap
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    item['icon'],
                    color: item['color'],
                    size: 30,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}