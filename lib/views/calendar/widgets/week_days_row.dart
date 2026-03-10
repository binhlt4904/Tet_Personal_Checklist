import 'package:flutter/material.dart';

class WeekDaysRow extends StatelessWidget {
  const WeekDaysRow({super.key});

  @override
  Widget build(BuildContext context) {
    const days = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];

    return Row(
      children: days
          .map((d) => Expanded(
        child: Center(
          child: Text(
            d,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
        ),
      ))
          .toList(),
    );
  }
}