import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? imagePath;

  const TagChip({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: imagePath != null
          ? Image.asset(imagePath!, width: 18, height: 18)
          : (icon != null ? Icon(icon, size: 18) : null),
      label: Text(label),
    );
  }
}
