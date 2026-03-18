import 'package:flutter/material.dart';

class BackgroundDecorations extends StatelessWidget {
  const BackgroundDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 24, left: 16, child: _Lantern()),
        Positioned(top: 24, right: 16, child: _Lantern()),
        Positioned(bottom: 24, left: 16, child: _Lantern()),
        Positioned(bottom: 24, right: 16, child: _Lantern()),
      ],
    );
  }
}

class _Lantern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 12, color: const Color(0xFFB8860B)),
        Container(
          width: 28,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB8860B), width: 1.5),
          ),
          child: const Center(
            child: Text(
              '福',
              style: TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(width: 2, height: 8, color: const Color(0xFFB8860B)),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFFB8860B),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}