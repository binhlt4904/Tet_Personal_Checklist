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
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: item(Colors.orange, "Chưa hoàn thành")),
        Expanded(child: item(Colors.green, "Đã hoàn thành")),
        Expanded(child: item(Colors.red, "Quá hạn")),
      ],
    );
  }
}