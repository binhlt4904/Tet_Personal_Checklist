import 'package:flutter/material.dart';

class EditCard extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;

  const EditCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4)),
        ],
        border: Border.all(
          color: const Color(0xFFF0E8DA),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.red),
                const SizedBox(width: 6),
              ],
              Text(
                title,
                style: const TextStyle(
                    fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}