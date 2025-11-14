import 'package:flutter/material.dart';

class NoteInput extends StatelessWidget {
  const NoteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "(Makanan yang membuat Anda alergi, saus ekstra misalnya)",
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      maxLines: 2,
    );
  }
}
