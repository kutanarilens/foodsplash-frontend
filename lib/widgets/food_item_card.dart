import 'package:flutter/material.dart';
import 'package:foodsplash/models/menu_item.dart';

class FoodItemCard extends StatelessWidget {
  final MenuItem item;
  // final String title;
  // final String distance;
  // final String rating;

  // final String imageUrl = 'assets/food_placeholder.jpg';

  const FoodItemCard({
    // required this.title,
    // required this.distance,
    // required this.rating,
    super.key,
    required this.item,
  });
  ImageProvider _imageProviderGetter() {
    final placeholderUrl = "asset/food_placeholder.jpg";
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return NetworkImage(item.imageUrl!);
    } else {
      return AssetImage(placeholderUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String tampilanRating =
        (item.avgRating != null && item.reviewsCount != null)
        ? "⭐ ${item.avgRating!.toStringAsFixed(1)}${item.reviewsCount}rb+ rating"
        : "Belum ada rating";

    final String? tampilkanJarak = (item.jarak != null)
        ? "${item.jarak!.toStringAsFixed(0)} KM"
        : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Image(
                  image: _imageProviderGetter(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, StackTrace) => const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tampilkanJarak} · 30-46 mnt',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),

                Text(
                  item.namaMenu,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "${tampilanRating},",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),

                // Row(
                //   children: [
                //     Icon(Icons.star, color: Colors.amber, size: 14),
                //     SizedBox(width: 4),
                //     Text(
                //       rating,
                //       style: TextStyle(fontSize: 12, color: Colors.black54),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
