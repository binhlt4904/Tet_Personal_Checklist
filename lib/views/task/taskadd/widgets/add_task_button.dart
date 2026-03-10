import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTaskButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD32F2F),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: const Text(
          "Thêm vào danh sách",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}