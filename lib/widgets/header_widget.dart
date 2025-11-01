import 'package:flutter/material.dart';
import 'package:foodsplash/pages/chat_list_page.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Image(
              image: AssetImage("assets/images/foodsplash.png"),
              width: 75,
              // height: 30,
            ),
            // Text(
            //   'foodSplash',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.lightBlue,
            //   ),
            // ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Lagi mau makan apa?', 
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Notifications',
              icon: const Icon(Icons.notifications_rounded, color: Colors.lightBlueAccent),
              onPressed: () {},
            ),
            SizedBox(width: 10),
            IconButton(
              tooltip: 'Messages',
              icon: const Icon(Icons.chat_bubble, color: Colors.lightBlueAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatListPage()),
                );
              },
            ),
          ],
        ),

        SizedBox(height: 15),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50], 
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.location_on, color: Colors.lightBlue, size: 20),
              SizedBox(width: 5),
              Text(
                'Jl. Kampung Mangga No.53', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  fontSize: 12
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.lightBlue, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
