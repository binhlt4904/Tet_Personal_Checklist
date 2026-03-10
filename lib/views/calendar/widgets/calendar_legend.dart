import 'package:flutter/material.dart';

class CalendarLegend extends StatelessWidget {
  const CalendarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    Widget item(Color color, String text) {
      return Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 6),
          Text(text),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        item(Colors.orange, "Chưa hoàn thành"),
        item(Colors.green, "Đã hoàn thành"),
        item(Colors.red, "Quá hạn"),
      ],
    );
  }
}