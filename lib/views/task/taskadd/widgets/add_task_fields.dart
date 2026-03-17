import 'package:flutter/material.dart';

class AddTaskFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String room;
  final Function(String) onRoomChanged;

  // 👇 thêm validator từ ngoài truyền vào
  final String? Function(String?)? titleValidator;
  final String? Function(String?)? descriptionValidator;

  const AddTaskFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.room,
    required this.onRoomChanged,
    this.titleValidator,
    this.descriptionValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TITLE
        TextFormField(
          controller: titleController,
          decoration: _inputDecoration("VD: Lau dọn tủ lạnh..."),
          validator: titleValidator,
        ),
        const SizedBox(height: 14),

        /// DESCRIPTION
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: _inputDecoration("Mô tả chi tiết (không bắt buộc)"),
          validator: descriptionValidator,
        ),
        const SizedBox(height: 14),

        /// ROOM
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: room,
              isExpanded: true,
              items: const [
                'Phòng khách',
                'Phòng ngủ',
                'Nhà bếp',
                'Nhà vệ sinh',
                'Ban công',
                'Phòng thờ'
              ]
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (v) => onRoomChanged(v!),
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
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    );
  }
}