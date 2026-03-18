import 'package:flutter/material.dart';

class AuthBackLink extends StatelessWidget {
  final VoidCallback? onTap;

  const AuthBackLink({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: const Text(
          '← Quay về trang chủ',
          style: TextStyle(
            color: Color(0xFF888888),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}