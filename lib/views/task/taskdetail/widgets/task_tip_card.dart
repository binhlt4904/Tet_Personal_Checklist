import 'package:flutter/material.dart';

class TaskTipCard extends StatelessWidget {
  const TaskTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6E3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Mẹo nhỏ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text("• Chuẩn bị dụng cụ trước khi bắt đầu"),
          SizedBox(height: 6),
          Text("• Làm việc từ trên xuống dưới"),
          SizedBox(height: 6),
          Text("• Nghỉ ngơi 5-10 phút sau mỗi 45 phút làm việc để tránh mệt mỏi"),
        ],
      ),
    );
  }
}