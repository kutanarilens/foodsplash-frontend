import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                  ],
                ),
              ),

            ],
          ),
        ),

        SizedBox(height: 15),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white, // Latar belakang merah muda
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          child: Row(
            children: [
              SizedBox(width: 5),
              Image(
                image: AssetImage("assets/images/foodsplashturbo.png"),
                width: 100,
                // height: 100,
              ),
              SizedBox(width: 10),
              Text(
                'Belanja secepat kilat, 2 Jam tiba!',
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
