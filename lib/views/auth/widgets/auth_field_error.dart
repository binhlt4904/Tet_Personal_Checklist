import 'package:flutter/material.dart';

class AuthFieldError extends StatelessWidget {
  final String? message;

  const AuthFieldError(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 12, color: Color(0xFFE53935)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              message!,
              style: const TextStyle(fontSize: 11, color: Color(0xFFE53935)),
            ),
          ),
        ],
      ),
    );
  }
}