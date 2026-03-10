import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const Header({
    super.key,
    required this.title,
    this.description,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (canPop) ...[
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 12), // 👈 khoảng cách với title
          ],

          Expanded(
            child: Column(
              crossAxisAlignment:
              canPop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign:
                  canPop ? TextAlign.start : TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    description!,
                    textAlign:
                    canPop ? TextAlign.start : TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}