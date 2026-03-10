import 'package:flutter/material.dart';

class EmptyTaskBox extends StatelessWidget {
  const EmptyTaskBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Column(
        children: [
          Icon(Icons.calendar_today,
              size: 50, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            "Chọn một ngày để xem công việc",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Nhấn vào ngày trên lịch để xem chi tiết",
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}