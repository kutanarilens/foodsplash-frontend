import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final String child;

  const MainLayout({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("data")));
  }
}
