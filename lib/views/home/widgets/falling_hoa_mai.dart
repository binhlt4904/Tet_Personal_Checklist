import 'dart:math';
import 'package:flutter/material.dart';

class FallingHoaMai extends StatefulWidget {
  const FallingHoaMai({super.key});

  @override
  State<FallingHoaMai> createState() => _FallingHoaMaiState();
}

class Flower {
  double x;
  double size;
  double speed;
  double sway;

  Flower(this.x, this.size, this.speed, this.sway);
}

class _FallingHoaMaiState extends State<FallingHoaMai>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  final Random random = Random();

  final List<Flower> flowers = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    /// tạo hoa
    for (int i = 0; i < 20; i++) {
      flowers.add(
        Flower(
          random.nextDouble(),
          14 + random.nextDouble() * 10,
          200 + random.nextDouble() * 200,
          random.nextDouble() * 40,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {

        final progress = controller.value;

        return Stack(
          children: flowers.map((flower) {

            final y = progress * flower.speed;

            final x = flower.x * width +
                sin(progress * 2 * pi) * flower.sway;

            final rotation = progress * 2 * pi;

            return Positioned(
              top: y,
              left: x,
              child: Transform.rotate(
                angle: rotation,
                child: Icon(
                  Icons.filter_vintage,
                  color: Colors.yellow.shade600,
                  size: flower.size,
                ),
              ),
            );

          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}