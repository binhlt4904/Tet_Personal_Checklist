import 'package:flutter/material.dart';

class EditTaskNoteBox extends StatelessWidget {
  const EditTaskNoteBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "Lưu ý khi chỉnh sửa",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text("• Các trường có dấu * là bắt buộc"),
          SizedBox(height: 6),
          Text("• Thay đổi sẽ được lưu ngay khi bạn nhấn \"Lưu thay đổi\""),
          SizedBox(height: 6),
          Text("• Trạng thái hoàn thành sẽ được giữ nguyên"),
        ],
      ),
    );
  }
}