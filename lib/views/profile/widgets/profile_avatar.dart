import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String email;
  final String goal;

  const ProfileAvatar({
    super.key,
    required this.name,
    required this.email,
    this.goal = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD32F2F),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 40),
        ),

        const SizedBox(height: 12),

        // Tên
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        // Email
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 16, color: Colors.grey),
            const SizedBox(width: 6),
            Text(email, style: const TextStyle(color: Colors.grey)),
          ],
        ),

        if (goal.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF4B942), width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flag_rounded,
                    color: Color(0xFFD32F2F), size: 16),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    goal,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5D4037),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}