import 'package:flutter/material.dart';

class TipsHeader extends StatelessWidget {
  const TipsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF9800),
            Color(0xFFFF6A00),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: const [
          Row(

          ),
          SizedBox(height: 20),
          Text(
            "Hướng dẫn & Mẹo hay",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Dọn nhà nhanh gọn, đón Tết sum vầy",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}