import 'package:flutter/material.dart';

class EditProfileFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController goalController;
  final String? Function(String?)? nameValidator;

  const EditProfileFields({
    super.key,
    required this.nameController,
    required this.goalController,
    this.nameValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Họ và tên",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF222222),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: nameController,
          decoration: _inputDecoration("Nguyễn Văn A"),
          validator: nameValidator,
        ),

        const SizedBox(height: 20),


        const Text(
          "Mục tiêu bản thân",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF222222),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: goalController,
          maxLength: 150,
          maxLines: 3,
          decoration: _inputDecoration("Ví dụ: Hoàn thành 30 task trong tháng này 🎯")
              .copyWith(
            counterStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(bottom: 48), // căn icon lên trên
              child: Icon(Icons.flag_rounded, color: Color(0xFFD32F2F), size: 20),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}