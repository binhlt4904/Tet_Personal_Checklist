import 'package:flutter/material.dart';

class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.red.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.card_giftcard,
                  color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Lời khuyên trước khi bắt đầu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildItem(
              "Lên kế hoạch chi tiết và chia nhỏ công việc để không bị quá tải"),
          _buildItem(
              "Chuẩn bị đầy đủ dụng cụ và vật liệu trước khi bắt đầu"),
          _buildItem(
              "Đừng quên nghỉ ngơi để tránh mệt mỏi, sức khỏe là quan trọng nhất!"),
        ],
      ),
    );
  }

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}