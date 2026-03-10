import 'package:flutter/material.dart';

class EditTaskButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const EditTaskButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: const Text("Hủy bỏ", style: TextStyle(color: Colors.black),),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
            ),
            child: const Text(
              "Lưu thay đổi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}